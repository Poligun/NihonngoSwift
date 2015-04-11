//
//  SlideViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/30.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import UIKit

protocol SlideViewDelegate {
    func toggleLeftView()
}

class SlideViewController: UIViewController, SlideViewDelegate {
    
    var leftViewWidth: CGFloat = 240
    var minimumCenterViewX: CGFloat = 0
    var maximumCenterViewX: CGFloat = 240

    private var leftViewController: UIViewController?
    private var rightViewController: UIViewController?
    private var currentCenterViewController: UIViewController?
    private var centerViewControllers = [String: UIViewController]()
    private var sliddingState: SliddingState = .BothHidden {
        didSet {
            setCenterViewShadow(sliddingState != .BothHidden)
        }
    }
    
    private enum SliddingState {
        case BothHidden
        case LeftShown
        case RightShown
    }
    
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPanGesture:")

        UINavigationBar.appearance().barTintColor = Theme.currentTheme.navigationBarBackgroundColor
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState: UIControlState.Normal)
        
        UISearchBar.appearance().showsCancelButton = true
        UISearchBar.appearance().barTintColor = Theme.currentTheme.searchBarBackgroundColor
        UISearchBar.appearance().layer.borderWidth = 1.0
        UISearchBar.appearance().layer.borderColor = UISearchBar.appearance().barTintColor!.CGColor
        UISearchBar.appearance().getSearchField()?.backgroundColor = Theme.currentTheme.searchFieldBackgroundColor
        UISearchBar.appearance().getSearchField()?.textColor = UIColor.blackColor()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func setCenterViewControllerForName(name: String) {
        var newViewController = centerViewControllers[name]
        if newViewController != nil && newViewController != currentCenterViewController {
            var originX: CGFloat = 0.0
            if let current = currentCenterViewController {
                originX = current.view.frame.origin.x
                current.view.removeGestureRecognizer(panGestureRecognizer)
                current.view.removeFromSuperview()
                current.removeFromParentViewController()
            }
            view.addSubview(newViewController!.view)
            newViewController!.view.frame.origin.x = originX
            addChildViewController(newViewController!)
            newViewController!.didMoveToParentViewController(self)
            newViewController!.view.addGestureRecognizer(panGestureRecognizer)
            currentCenterViewController = newViewController!
        }
        showLeftView(false)
    }
    
    func addCenterViewController(viewController: UIViewController, forName name: String, setAsCurrent: Bool = true) {
        centerViewControllers[name] = viewController
        if setAsCurrent {
            setCenterViewControllerForName(name)
        }
    }
    
    func setLeftViewController(viewController: UIViewController, width: CGFloat = 150.0) {
        if let previous = leftViewController {
            previous.view.removeFromSuperview()
            previous.removeFromParentViewController()
        }
        view.insertSubview(viewController.view, atIndex: 0)
        addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
        leftViewController = viewController
        
        leftViewWidth = width
        maximumCenterViewX = min(leftViewWidth * 1.5, view.frame.width)
    }
    
    func toggleLeftView() {
        showLeftView(sliddingState != .LeftShown)
    }
    
    private func showLeftView(shown: Bool) {
        if shown {
            sliddingState = .LeftShown
            animateCenterViewPosition(toPosition: leftViewWidth)
        } else {
            animateCenterViewPosition(toPosition: 0) { finished in
                self.sliddingState =  .BothHidden
            }
        }
    }
    
    func onPanGesture(recognizer: UIPanGestureRecognizer) {
        if currentCenterViewController is UINavigationController {
            let navigationViewController = currentCenterViewController as UINavigationController
            if navigationViewController.visibleViewController! != navigationViewController.viewControllers[0] as UIViewController {
                return
            }
        }
        switch recognizer.state {
        case .Began:
            setCenterViewShadow(sliddingState == .BothHidden)
        case .Changed:
            let newX = recognizer.view!.frame.origin.x + recognizer.translationInView(view).x
            if minimumCenterViewX <= newX && newX <= maximumCenterViewX {
                recognizer.view!.frame.origin.x = newX
            }
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            showLeftView(recognizer.velocityInView(view).x > 0)
        default:
            break
        }
    }
    
    private func animateCenterViewPosition(#toPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        if currentCenterViewController != nil {
            UIView.animateWithDuration(0.5, delay: 0.0,
                           usingSpringWithDamping: 0.8,
                            initialSpringVelocity: 0.0,
                                          options: .CurveEaseInOut,
                                       animations: {
                self.currentCenterViewController!.view.frame.origin.x = toPosition
                }, completion: completion)
        }
    }
    
    private func setCenterViewShadow(hasShadow: Bool) {
        if hasShadow {
            self.currentCenterViewController?.view.layer.shadowOpacity = 0.8
        } else {
            self.currentCenterViewController?.view.layer.shadowOpacity = 0.0
        }
        
    }
}
