//
//  SampleViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 27/06/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit
import SimpleWizzard

class SampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openWizardAction(_ sender: UIButton) {
        self.present(SampleWizardController(), animated: true, completion: nil)
    }
}
