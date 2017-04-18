//
//  StepPageViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 17/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

protocol StepPageViewControllerDelegate: class {
    
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

class StepPageViewController: UIPageViewController, MoveStepDelegate {
    
    weak var stepDelegate: StepPageViewControllerDelegate?
    var currentIndex = 0
    
    var orderedViewControllers: [StepViewController]?
    
    var currentViewController: StepViewController?
    
    convenience init() {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstViewController = orderedViewControllers?.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageCount: orderedViewControllers!.count)
            currentViewController = orderedViewControllers?.first
        }
    }
    
    func verifyNext() {
        if currentViewController?.delegate != nil && currentViewController!.delegate!.verifyNext() {
        
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
            self.setViewControllers([currentViewController!], direction: .forward, animated: true, completion: nil)
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: nextIndex)
            
            if orderedViewControllersCount - 1 == nextIndex {
                currentViewController?.nextButton?.setImage(UIImage(named: "done"), for: .normal)
            }
        }
    }
    
    func verifyPrev() {
        if currentViewController?.delegate != nil && currentViewController!.delegate!.verifyPrev() {
        
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
            self.setViewControllers([currentViewController!], direction: .reverse, animated: true, completion: nil)
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: previousIndex)
            
            currentViewController?.nextButton?.setImage(UIImage(named: "right"), for: .normal)
        }
    }
}
