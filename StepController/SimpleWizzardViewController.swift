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
}

class SimpleWizzardViewController: UIViewController, StepPageViewControllerDelegate {

    var pageDots: UIPageControl!
    var prevButton: UIButton!
    var nextButton: UIButton!
    
    var delegate: MoveStepDelegate?
    
    var pageViewController: StepPageViewController?
    
    func generate(_ childViews: [StepViewController]) {
        self.pageViewController = StepPageViewController()
        self.setChildViews(childViews)
        
        self.pageViewController?.stepDelegate = self
        self.delegate = self.pageViewController
        
        self.prevButton = UIButton()
        self.prevButton.setImage(UIImage(named: "left"), for: .normal)
        self.prevButton.addTarget(self, action: #selector(SimpleWizzardViewController.prevAction(_:)), for: .touchUpInside)
        
        self.nextButton = UIButton()
        self.nextButton.setImage(UIImage(named: "right"), for: .normal)
        self.nextButton.addTarget(self, action: #selector(SimpleWizzardViewController.nextAction(_:)), for: .touchUpInside)
        
        self.pageDots = UIPageControl()
        self.pageDots.pageIndicatorTintColor = UIColor.gray
        self.pageDots.currentPageIndicatorTintColor = UIColor.black
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, pageDots, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        self.pageViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageViewController!.view)
        
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[stackView]-8-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[stackView(44)]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["stackView": stackView])
        self.view.addConstraints(stackView_H)
        self.view.addConstraints(stackView_V)
        
        let pageView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["pageView": self.pageViewController!.view])
        let pageView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-44-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["pageView": self.pageViewController!.view])
        self.view.addConstraints(pageView_H)
        self.view.addConstraints(pageView_V)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Configure Every Component and add the Child Views
            self.generate(_ childViews: [StepViewController])
         */
        
        /* Styling
            The user can personalize the buttons
         */
    }
    
    func setChildViews(_ childViews: [StepViewController]) {
        self.pageViewController?.orderedViewControllers = childViews
        self.configStepView(self.pageViewController!.orderedViewControllers!.first!)
    }
    
    func configStepView(_ stepViewController: StepViewController) {
        stepViewController.nextButton = self.nextButton
        stepViewController.prevButton = self.prevButton
        stepViewController.pageControlDots = self.pageDots
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
        self.delegate?.verifyPrev()
    }
    
    func nextAction(_ sender: UIButton) {
        self.delegate?.verifyNext()
    }
}

