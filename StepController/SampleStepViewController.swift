//
//  SampleStepViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 18/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

class SampleStepViewController: StepViewController, ChangeStepDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func verifyNext() -> Bool {
        return true
    }

    func verifyPrev() -> Bool {
        return true
    }
}
