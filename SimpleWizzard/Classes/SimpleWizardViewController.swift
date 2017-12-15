//
//  SimpleWizzardViewController.swift
//  SimpleWizard
//
//  Created by Higor Borjaille on 17/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

public protocol MoveStepDelegate {
    func verifyPrev() -> Void
    func verifyNext() -> Void
    func verifyDone() -> Bool
}

public protocol CancelDelegate {
    func cancel()
}

open class SimpleWizardViewController: UINavigationController, StepPageViewControllerDelegate {
    
    // Wizzard instance holder
    public static var wizardInstance: SimpleWizardViewController?
    
    // Visual Components
    public var nextImage: UIImage?
    public var prevImage: UIImage?
    public var doneImage: UIImage?
    
    public var pageDots: UIPageControl?
    public var prevButton: UIButton?
    public var nextButton: UIButton?
    
    open override var title: String? {
        get {
            return self.wrapController?.navigationItem.title
        }
        set {
            self.wrapController?.navigationItem.title = newValue
        }
    }
    
    open var nextViewController: UIViewController? {
        get {
            return self.pageViewController?.nextViewController
        }
    }
    
    // Needed Delegates
    var moveDelegate: MoveStepDelegate?
    public var cancelDelegate: CancelDelegate?
    
    // ViewCOntroller that will wrap every component together
    public var wrapController: UIViewController?
    
    // Page View Controller that will manage the transition
    var pageViewController: StepPageViewController?
    
    func setWizard() {
        // Removes the previous instance if there is one already
        if let instance = SimpleWizardViewController.wizardInstance {
            instance.clearWizard()
            instance.dismiss(animated: false, completion: nil)
        }
        
        // Generates and binds the new instance
        SimpleWizardViewController.wizardInstance = self
    }
    
    // Function that manage the only Wizard instance
    public func generate(_ childViews: [UIViewController]) {
        
        // Initializing the WrapperViewController
        wrapController = UIViewController()
        wrapController?.view.backgroundColor = UIColor.white
        
        // Initializing StepPageViewController
        self.pageViewController = StepPageViewController()
        self.pageViewController?.wizzard = self
        
        // Setting Child Views
        self.setChildViews(childViews)
        
        // Setting up the Delegates
        self.pageViewController?.stepDelegate = self
        self.moveDelegate = self.pageViewController
        
        // Setting up Interface
        self.prevButton = UIButton()
        self.prevButton?.setImage(self.prevImage, for: .normal)
        self.prevButton?.addTarget(self, action: #selector(SimpleWizardViewController.prevAction(_:)), for: .touchUpInside)
        
        self.nextButton = UIButton()
        self.nextButton?.setImage(self.nextImage, for: .normal)
        self.nextButton?.addTarget(self, action: #selector(SimpleWizardViewController.nextAction(_:)), for: .touchUpInside)
        
        self.pageDots = UIPageControl()
        self.pageDots?.pageIndicatorTintColor = UIColor.gray
        self.pageDots?.currentPageIndicatorTintColor = UIColor.black
        self.pageDots?.isUserInteractionEnabled = false
        
        // Setting up Constraints
        let stackView = UIStackView(arrangedSubviews: [prevButton!, pageDots!, nextButton!])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        wrapController?.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        
        let pageView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[pageView]-(0)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["pageView": self.pageViewController!.view])
        let pageView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(60)-[pageView]-(44)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["pageView": self.pageViewController!.view, "stackView": stackView])
        wrapController?.view.addConstraints(pageView_H)
        wrapController?.view.addConstraints(pageView_V)
        
        
        wrapController?.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(8)-[stackView]-(8)-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["stackView": stackView])
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[stackView(44)]-(0)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["stackView": stackView])
        wrapController?.view.addConstraints(stackView_H)
        wrapController?.view.addConstraints(stackView_V)
        
        // Pushing the WrapViewController to a UINavigationController
        self.pushViewController(wrapController!, animated: true)
        self.wrapController?.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(self.cancelWizzard(_:))), animated: true)
        
        // Setting the Global Instance
        self.setWizard()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        //self.pushViewController(self.pageViewController!, animated: false)
        
        /* Configure Every Component and add the Child Views
            self.generate(_ childViews: [StepViewController])
         */
        
        /* Styling
            The user can personalize the buttons
         */
    }
    
    public func clearWizard() {
        self.nextButton = nil
        self.prevButton = nil
        self.pageDots = nil
        self.moveDelegate = nil
        self.wrapController = nil
        self.pageViewController?.wizzard = nil
        self.popToRootViewController(animated: true)
        SimpleWizardViewController.wizardInstance = nil
        self.cancelDelegate = nil
    }
    
    @objc func cancelWizzard(_ gesture: UITapGestureRecognizer) {
        self.cancelDelegate?.cancel()
    }
    
    func setChildViews(_ childViews: [UIViewController]) {
        self.pageViewController?.orderedViewControllers = childViews
    }
    
    public func stepPageViewController(viewController: UIViewController, didUpdatePageCount count: Int) {
        self.pageDots?.numberOfPages = count
    }
    
    public func stepPageViewController(viewController: UIViewController, didUpdatePageIndex index: Int) {
        self.pageDots?.currentPage = index
    }
    
    public func next() {
        if self.pageViewController?.currentViewController == self.pageViewController?.orderedViewControllers?.last {
            if let val = self.moveDelegate?.verifyDone() {
                if val {
                    self.clearWizard()
                    self.cancelDelegate = nil
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            self.pageViewController?.goToNext()
        }
        
    }
    
    public func prev() {
        self.pageViewController?.goToPrev()
    }
    
    @objc func prevAction(_ sender: UIButton) {
        self.moveDelegate?.verifyPrev()
    }
    
    @objc func nextAction(_ sender: UIButton) {
        if self.pageViewController?.currentViewController == self.pageViewController?.orderedViewControllers?.last {
            if let val = self.moveDelegate?.verifyDone() {
                if val {
                    self.clearWizard()
                    self.cancelDelegate = nil
                    self.dismiss(animated: true, completion: nil)
                }
            }
        } else {
            self.moveDelegate?.verifyNext()
        }
    }
    
    deinit {
        self.pageViewController?.view.removeFromSuperview()
        self.pageViewController?.removeFromParentViewController()
        self.pageViewController = nil
    }
}

