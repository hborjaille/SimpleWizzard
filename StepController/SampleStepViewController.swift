//
//  SampleStepViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 18/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

class SampleStepViewController: StepViewController, ChangeStepDelegate {
    @IBOutlet weak var numberLabel: UILabel!
    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        numberLabel.text = number?.description
    }
    
    func verifyNext() -> Bool {
        if nextButton?.imageView?.image == UIImage(named: "done") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.present(storyboard.instantiateViewController(withIdentifier: "doneViewController"), animated: true, completion: nil)
        }
        return true
    }

    func verifyPrev() -> Bool {
        return true
    }
}
