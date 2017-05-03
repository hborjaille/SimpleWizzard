//
//  StepViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 18/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

protocol ChangeStepDelegate {
    func verifyNext() -> Void
    func verifyPrev() -> Void
}

class StepViewController: UIViewController {
    
    var prevButton: UIButton?
    var nextButton: UIButton?
    var pageControlDots: UIPageControl?
    
    var delegate: ChangeStepDelegate?
    private var wizzard: SimpleWizzardViewController?
    
    public var nextViewController: UIViewController? {
        get {
            return wizzard?.pageViewController?.nextViewController
        }
    }
    
    public var navItem: UINavigationItem? {
        get {
            return wizzard?.pageViewController?.navigationItem
        }
    }
    
    public func setWizzard(_ wizzard: SimpleWizzardViewController) {
        self.wizzard = wizzard
        self.nextButton = wizzard.nextButton
        self.prevButton = wizzard.prevButton
        self.pageControlDots = wizzard.pageDots
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let wizzard = self.wizzard {
            wizzard.present(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            super.present(viewControllerToPresent, animated: flag)
        }
    }
    
    public func goToNext() {
        self.wizzard?.pageViewController?.goToNext()
    }
    
    public func goToPrev() {
        self.wizzard?.pageViewController?.goToPrev()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
