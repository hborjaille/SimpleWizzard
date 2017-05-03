//
//  SimpleWizzardViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 17/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

protocol MoveStepDelegate {
    func verifyPrev() -> Void
    func verifyNext() -> Void
    func verifyDone() -> Bool
}

protocol CancelDelegate {
    func cancel()
}

class SimpleWizzardViewController: UINavigationController, StepPageViewControllerDelegate {
    var pageDots: UIPageControl!
    var prevButton: UIButton!
    var nextButton: UIButton!
    
    var moveDelegate: MoveStepDelegate?
    var cancelDelegate: CancelDelegate?
    
    var pageViewController: StepPageViewController?
    
    func generate(_ childViews: [UIViewController], _ buttonColor: UIColor? = UIColor.black, _ doneButtonColor: UIColor? = UIColor(red: 0, green: 0.6953125, blue: 0, alpha: 1)) {
        self.pageViewController = StepPageViewController()
        self.pageViewController?.buttonColor = buttonColor
        self.pageViewController?.doneButtonColor = doneButtonColor
        
        self.setChildViews(childViews)
        
        self.pageViewController?.stepDelegate = self
        self.pageViewController?.cancelDelegate = cancelDelegate
        self.moveDelegate = self.pageViewController
        
        self.prevButton = UIButton()
        self.prevButton.setImage(UIImage(named: "left")?.maskWithColor(color: buttonColor!), for: .normal)
        self.prevButton.addTarget(self, action: #selector(SimpleWizzardViewController.prevAction(_:)), for: .touchUpInside)
        
        self.nextButton = UIButton()
        self.nextButton.setImage(UIImage(named: "right")?.maskWithColor(color: buttonColor!), for: .normal)
        self.nextButton.addTarget(self, action: #selector(SimpleWizzardViewController.nextAction(_:)), for: .touchUpInside)
        
        self.pageDots = UIPageControl()
        self.pageDots.pageIndicatorTintColor = UIColor.gray
        self.pageDots.currentPageIndicatorTintColor = UIColor.black
        self.pageDots.isUserInteractionEnabled = false
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, pageDots, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[stackView]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[stackView(44)]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["stackView": stackView])
        self.view.addConstraints(stackView_H)
        self.view.addConstraints(stackView_V)
        
        self.pageViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageViewController!.view)
        
        let pageView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["pageView": self.pageViewController!.view])
        let pageView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[pageView]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["pageView": self.pageViewController!.view, "stackView": stackView])
        self.view.addConstraints(pageView_H)
        self.view.addConstraints(pageView_V)
        
        let bottomConst = pageViewController?.view.bottomAnchor.constraint(equalTo: stackView.topAnchor)
        self.view.addConstraint(bottomConst!)
        
        for child in childViews {
            if let viewController = child as? StepViewController {
                viewController.setWizzard(self)
            } else if let tableViewController = child as? StepTableViewController {
                tableViewController.setWizzard(self)
            } else if let collectionViewController = child as? StepCollectionViewController {
                collectionViewController.setWizzard(self)
            }
        }
        
        self.pushViewController(self.pageViewController!, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.pushViewController(self.pageViewController!, animated: false)
        
        /* Configure Every Component and add the Child Views
            self.generate(_ childViews: [StepViewController])
         */
        
        /* Styling
            The user can personalize the buttons
         */
    }
    
    func setChildViews(_ childViews: [UIViewController]) {
        self.pageViewController?.orderedViewControllers = childViews
        self.configStepView(self.pageViewController!.orderedViewControllers!.first!)
    }
    
    func configStepView(_ viewController: UIViewController) {
        if let viewController = viewController as? StepViewController {
            viewController.nextButton = self.nextButton
            viewController.prevButton = self.prevButton
            viewController.pageControlDots = self.pageDots
        } else if let tableViewController = viewController as? StepTableViewController {
            tableViewController.nextButton = self.nextButton
            tableViewController.prevButton = self.prevButton
            tableViewController.pageControlDots = self.pageDots
        } else if let collectionViewController = viewController as? StepCollectionViewController {
            collectionViewController.nextButton = self.nextButton
            collectionViewController.prevButton = self.prevButton
            collectionViewController.pageControlDots = self.pageDots
        }
    }
    
    func stepPageViewController(viewController: UIViewController,
                                 didUpdatePageCount count: Int) {
        self.pageDots.numberOfPages = count
        
    }
    
    func stepPageViewController(viewController: UIViewController,
                                 didUpdatePageIndex index: Int) {
        self.pageDots.currentPage = index
        if let stepPageViewController = viewController as? StepPageViewController {
            if let stepViewController = stepPageViewController.currentViewController {
                configStepView(stepViewController)
            }
        }
    }
    
    func prevAction(_ sender: UIButton) {
        self.moveDelegate?.verifyPrev()
    }
    
    func nextAction(_ sender: UIButton) {
        if self.pageViewController?.currentViewController == self.pageViewController?.orderedViewControllers?.last {
            if let val = self.moveDelegate?.verifyDone() {
                if val { self.dismiss(animated: true, completion: nil) }
            }
        } else {
            self.moveDelegate?.verifyNext()
        }
    }
    
    deinit {
        self.pageViewController = nil
    }
}

