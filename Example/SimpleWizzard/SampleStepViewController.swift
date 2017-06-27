//
//  SampleStepViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 27/06/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit
import SimpleWizzard

class SampleStepViewController: UIViewController, ChangeStepDelegate {

    @IBOutlet var pageNumber: UILabel!

    var pageNumberText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pageNumber.text = pageNumberText
    }
    
    @IBAction func clickAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Testing \(pageNumberText!)", message: "It Works!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.presentWithWizard(alert, animated: true)
    }

    func verifyNext() -> Bool {
        if let controller = SampleWizardController.wizardInstance?.nextViewController as? SampleStepViewController {
            if controller.pageNumberText == "5" {
                controller.pageNumberText = "Last"
            }
        }
        SampleWizardController.wizardInstance?.next()
        return false
    }
    
    func verifyPrev() -> Bool {
        return true
    }
}
