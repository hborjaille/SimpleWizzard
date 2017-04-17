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

class StepPageViewController: UIPageViewController, UIPageViewControllerDelegate, MovePageDelegate {
    
    weak var stepDelegate: StepPageViewControllerDelegate?
    var currentIndex = 0
    
    var orderedViewControllers: [UIViewController]?
    
    var currentViewController:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.orderedViewControllers = []
        
        for _ in 0...8 {
            self.orderedViewControllers?.append(storyboard.instantiateViewController(withIdentifier: "dataViewController") as! DataViewController)
        }
        
        if let firstViewController = orderedViewControllers?.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageCount: orderedViewControllers!.count)
            currentViewController = orderedViewControllers?.first
        }
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers?.index(of: firstViewController) {
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: index)
        }
    }
    
    func next() {
        
        guard let viewControllerIndex = orderedViewControllers?.index(of: currentViewController!) else {
            return
        }
        
        let nextIndex = viewControllerIndex + 1
        if let orderedViewControllersCount = orderedViewControllers?.count {
            guard orderedViewControllersCount != nextIndex else {
                currentViewController = orderedViewControllers?.first
                self.setViewControllers([currentViewController!], direction: .forward, animated: true, completion: nil)
                self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: 0)
                return
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return
            }
        }
        
        currentViewController = orderedViewControllers?[nextIndex]
        self.setViewControllers([currentViewController!], direction: .forward, animated: true, completion: nil)
        self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: nextIndex)
    }
    
    func prev() {
        
        guard let viewControllerIndex = orderedViewControllers?.index(of: currentViewController!) else {
            return
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            currentViewController = orderedViewControllers?.last
            self.setViewControllers([currentViewController!], direction: .reverse, animated: true, completion: nil)
            self.stepDelegate?.stepPageViewController(viewController: self, didUpdatePageIndex: orderedViewControllers!.count - 1)
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
    }
}
