//
//  OnboardingViewController.swift
//  Logistics
//
//  Created by Daniyal Ansari on 11/20/17.
//  Copyright © 2017 com.tnb. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            self.setViewControllers([firstViewController],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
    }
    
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let skipButton = UIButton.init(type: .custom)
        skipButton.frame = CGRect(x: 10.0, y: (UIScreen.main.bounds.height - 36.0), width: 80.0, height: 36.0)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipOnbording), for: .touchUpInside)
        self.view.addSubview(skipButton)
        self.view.bringSubview(toFront: skipButton)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    // MARK: Class Methods
    
    @objc func skipOnbording() {
        OnboardingViewController.setOnboardingShown()
        self.dismiss(animated: true, completion: nil)
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.viewControllerPlacement(position: "1"),
                self.viewControllerPlacement(position: "2"),
                self.viewControllerPlacement(position: "3")]
    }()
    
    private func viewControllerPlacement(position: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil) .
            instantiateViewController(withIdentifier: "OnboardingViewController\(position)")
    }
    
    // MARK: UIPageViewControllerDataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    
    
    class func setOnboardingShown() {
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: GlobalData.USER_DEFAULTS_KEY_HAS_ONBOARDING_FLOW_SHOWN)
        userDefault.synchronize()
    }
    
    class func shouldShowOnboardingFlow() -> Bool {
        var onboardingFlowShown = true
        let userDefault = UserDefaults.standard
        if userDefault.value(forKey: GlobalData.USER_DEFAULTS_KEY_HAS_ONBOARDING_FLOW_SHOWN) != nil {
            onboardingFlowShown = false
        }
        
        return onboardingFlowShown
    }
    
}
