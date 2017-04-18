//
//  DoneViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 18/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
