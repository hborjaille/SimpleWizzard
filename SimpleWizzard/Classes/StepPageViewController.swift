//
//  StepPageViewController.swift
//  SimpleWizard
//
//  Created by Higor Borjaille on 17/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

public protocol ChangeStepDelegate {
    func verifyNext() -> Bool
    func verifyPrev() -> Bool
}

public protocol StepPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter introPageViewController: the introPageViewController instance
     - parameter count: the total number of pages.
     */
    func stepPageViewController(viewController: UIViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter introPageViewController: the introPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func stepPageViewController(viewController: UIViewController, didUpdatePageIndex index: Int)
    
}

open class StepPageViewController: UIPageViewController, MoveStepDelegate {
    
    weak var stepDelegate: StepPageViewControllerDelegate?
    var wizzard: SimpleWizardViewController?
    var currentIndex = 0
    
    var buttonColor: UIColor?
    var doneButtonColor: UIColor?
    
    var orderedViewControllers: [UIViewController]?
    
    var currentViewController: UIViewController?
    var nextViewController: UIViewController?
    
    convenience init() {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstViewController = orderedViewControllers?.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageCount: orderedViewControllers!.count)
            currentViewController = orderedViewControllers?.first
            if orderedViewControllers!.count > 1 {
                nextViewController = orderedViewControllers?[1]
            }
        }
    }
    
    func goToNext() {
        guard let viewControllerIndex = orderedViewControllers?.index(of: currentViewController!) else {
            return
        }
        
        let nextIndex = viewControllerIndex + 1
        guard let orderedViewControllersCount = orderedViewControllers?.count else {
            return
        }
        
        guard orderedViewControllersCount != nextIndex else {
            return
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return
        }
        
        currentViewController = orderedViewControllers?[nextIndex]
        if nextIndex + 1 < orderedViewControllersCount {
            nextViewController = orderedViewControllers?[nextIndex + 1]
        } else {
            nextViewController = nil
        }
        self.setViewControllers([currentViewController!], direction: .forward, animated: true, completion: nil)
        self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: nextIndex)
        
        if orderedViewControllersCount - 1 == nextIndex {
            self.wizzard?.nextButton?.setImage(self.wizzard?.doneImage, for: .normal)
        }
    }
    
    func goToPrev() {
        guard let viewControllerIndex = orderedViewControllers?.index(of: currentViewController!) else {
            return
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return
        }
        
        if let viewControllers = orderedViewControllers {
            guard viewControllers.count > previousIndex else {
                return
            }
        }
        
        currentViewController = orderedViewControllers?[previousIndex]
        nextViewController = orderedViewControllers?[viewControllerIndex]
        self.setViewControllers([currentViewController!], direction: .reverse, animated: true, completion: nil)
        self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: previousIndex)
        
        self.wizzard?.nextButton?.setImage(self.wizzard?.nextImage, for: .normal)
    }
    
    public func verifyNext() {
        if let viewController = currentViewController as? ChangeStepDelegate {
            if viewController.verifyNext() {
                self.goToNext()
            }
        }
    }
    
    public func verifyPrev() {
        if let viewController = currentViewController as? ChangeStepDelegate {
            if viewController.verifyPrev() {
                self.goToPrev()
            }
        }
    }
    
    public func verifyDone() -> Bool {
        if let _ = currentViewController as? ChangeStepDelegate {
            return true
        }
        return false
    }
    
    deinit {
        for child in self.orderedViewControllers! {
            child.removeFromParentViewController()
            child.dismiss(animated: true, completion: nil)
        }
        self.orderedViewControllers?.removeAll(keepingCapacity: false)
        self.orderedViewControllers = nil
        self.currentViewController = nil
    }
}
