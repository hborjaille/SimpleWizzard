//
//  SampleViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 18/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

class SampleViewController: SimpleWizzardViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var childViews = [StepViewController]()
        
        for i in 0...2 {
            let newView = storyboard.instantiateViewController(withIdentifier: "dataViewController") as! SampleStepViewController
            newView.number = i + 1
            childViews.append(newView)
        }
        
        self.generate(childViews)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
