//
//  NetworkRequestManager.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/8/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import SwiftyJSON

class NetworkRequestManager: NSObject {
    var currentEndpoint: Endpoint<NetworkHelper>?
    
    static let sharedInstance: NetworkRequestManager = NetworkRequestManager()
    public override init() { }
    
    func execute(request: NetworkHelper, withEndpointClosure endpointClosure: @escaping((NetworkHelper) -> Endpoint<NetworkHelper>), completion: @escaping Moya.Completion) {
        
        let provider = MoyaProvider<NetworkHelper>(endpointClosure: endpointClosure, manager : DefaultAlamofireManager.sharedManager)
        
        provider.request(request){
            result in
            switch result {
            case let .success(response):
                let json = try? JSON(response.mapJSON())
                if (json != nil) {
                    let success = json?["Success"] ?? false
                    if (success == false) {
                        let errorMessage = json?["ErrorMessage"].stringValue ?? ""
                        if errorMessage == "Un-authorized access" {
                            self.refreshAccessTokenForRequest(request: request, withEndpointClosure: endpointClosure, completion: completion)
                            return
                        }
                    }
                }
                break

            default:
                break
            }
            
            completion(result)
        }
    }
    
    
    func refreshAccessTokenForRequest(request: NetworkHelper, withEndpointClosure endpointClosure: @escaping ((NetworkHelper) -> Endpoint<NetworkHelper>), completion: @escaping Moya.Completion) {
        
        let refreshEndpointClosure = { (target: NetworkHelper) -> Endpoint<NetworkHelper> in
            let refreshEndpoint = Endpoint<NetworkHelper>(
                url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
            
            return refreshEndpoint.adding(newHTTPHeaderFields: ["Authorization": NetworkHelper.authorizationBasicValue, "Content-Type": "application/json"])
        }
        
        let refreshProvider = MoyaProvider<NetworkHelper>(endpointClosure: refreshEndpointClosure)
        refreshProvider.request(NetworkHelper.RefreshToken(RefreshToken: AuthenticationResponseManager.sharedInstance.fetchRefreshToken()!), completion: { result in
            
            switch result {
            case let .success(response):
                
                let infoDictionary = AuthenticationResponseManager.sharedInstance.processAuthenticationResponse(response: response)
                if (infoDictionary["HAS_ERROR"] as? Bool == false) {
                    print("NEW ACCESS TOKEN")
                    self.executePendingRequest(request: request, withEndpointClosure: endpointClosure, completion: completion)
                    return
                }
                break
                
            default:
                break
            }
            
            completion(result)
        })
        
    }
    
    
    func executePendingRequest(request: NetworkHelper, withEndpointClosure endpointClosure: @escaping ((NetworkHelper) -> Endpoint<NetworkHelper>), completion: @escaping Moya.Completion) {
        
        let pendingRequestClosure = { (target: NetworkHelper) -> Endpoint<NetworkHelper> in
            self.currentEndpoint = (self.currentEndpoint?.adding(newHTTPHeaderFields: ["Authorization": "Bearer\(AuthenticationResponseManager.sharedInstance.fetchAccessToken()! )"]))!
            return self.currentEndpoint!
        }
        
        let pendingRequestProvider = MoyaProvider<NetworkHelper>(endpointClosure: pendingRequestClosure)
        pendingRequestProvider.request(request, completion: { result in
            completion(result)
            
        })
    }
    
}


class DefaultAlamofireManager: Alamofire.SessionManager {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 20 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 20 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

