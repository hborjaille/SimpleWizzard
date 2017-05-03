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
    var cancelDelegate: CancelDelegate?
    var currentIndex = 0
    
    var buttonColor: UIColor?
    var doneButtonColor: UIColor?
    
    var orderedViewControllers: [UIViewController]?
    
    var currentViewController: UIViewController?
    var nextViewController: UIViewController?
    
    convenience init() {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelWizzard(_:))), animated: true)
        
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
    
    func cancelWizzard(_ gesture: UITapGestureRecognizer) {
        self.cancelDelegate?.cancel()
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
            if let viewController = currentViewController as? StepViewController {
                viewController.nextButton?.setImage(UIImage(named: "done_wizzard")?.maskWithColor(color: doneButtonColor!), for: .normal)
            } else if let tableViewController = currentViewController as? StepTableViewController {
                tableViewController.nextButton?.setImage(UIImage(named: "done_wizzard")?.maskWithColor(color: doneButtonColor!), for: .normal)
            } else if let collectionViewController = currentViewController as? StepCollectionViewController {
                collectionViewController.nextButton?.setImage(UIImage(named: "done_wizzard")?.maskWithColor(color: doneButtonColor!), for: .normal)
            }
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
        
        if let viewController = currentViewController as? StepViewController {
            viewController.nextButton?.setImage(UIImage(named: "right")?.maskWithColor(color: buttonColor!), for: .normal)
        } else if let tableViewController = currentViewController as? StepTableViewController {
            tableViewController.nextButton?.setImage(UIImage(named: "right")?.maskWithColor(color: buttonColor!), for: .normal)
        } else if let collectionViewController = currentViewController as? StepCollectionViewController {
            collectionViewController.nextButton?.setImage(UIImage(named: "right")?.maskWithColor(color: buttonColor!), for: .normal)
        }
    }
    
    func verifyNext() {
        if let viewController = currentViewController as? StepViewController {
            viewController.delegate?.verifyNext()
        } else if let tableViewController = currentViewController as? StepTableViewController {
            tableViewController.delegate?.verifyNext()
        } else if let collectionViewController = currentViewController as? StepCollectionViewController {
            collectionViewController.delegate?.verifyNext()
        }
    }
    
    func verifyPrev() {
        if let viewController = currentViewController as? StepViewController {
            viewController.delegate?.verifyPrev()
        } else if let tableViewController = currentViewController as? StepTableViewController {
            tableViewController.delegate?.verifyPrev()
        } else if let collectionViewController = currentViewController as? StepCollectionViewController {
            collectionViewController.delegate?.verifyPrev()
        }
    }
    
    func verifyDone() -> Bool {
        if let viewController = currentViewController as? StepViewController {
            if viewController.delegate != nil {
                viewController.delegate!.verifyNext()
                return true
            }
        } else if let tableViewController = currentViewController as? StepTableViewController {
            if tableViewController.delegate != nil {
                tableViewController.delegate!.verifyNext()
                return true
            }
        } else if let collectionViewController = currentViewController as? StepCollectionViewController {
            if collectionViewController.delegate != nil {
                collectionViewController.delegate!.verifyNext()
                return true
            }
        }
        return false
    }
    
    deinit {
        for child in self.orderedViewControllers! {
            
            if let viewController = child as? StepViewController {
                viewController.delegate = nil
                viewController.nextButton = nil
                viewController.pageControlDots = nil
                viewController.prevButton = nil
            } else if let tableViewController = child as? StepTableViewController {
                tableViewController.delegate = nil
                tableViewController.nextButton = nil
                tableViewController.pageControlDots = nil
                tableViewController.prevButton = nil
            } else if let collectionViewController = child as? StepCollectionViewController {
                collectionViewController.delegate = nil
                collectionViewController.nextButton = nil
                collectionViewController.pageControlDots = nil
                collectionViewController.prevButton = nil
            }
            child.removeFromParentViewController()
            child.dismiss(animated: true, completion: nil)
        }
        self.orderedViewControllers?.removeAll(keepingCapacity: false)
        self.orderedViewControllers = nil
        self.currentViewController = nil
    }
}
