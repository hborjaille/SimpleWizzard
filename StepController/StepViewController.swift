//
//  StepViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 18/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

protocol ChangeStepDelegate {
    func verifyNext() -> Bool
    func verifyPrev() -> Bool
}

class StepViewController: UIViewController {
    
    var prevButton: UIButton?
    var nextButton: UIButton?
    var pageControlDots: UIPageControl?
    
    var delegate: ChangeStepDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
