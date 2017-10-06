//
//  SampleWizzardController.swift
//  StepController
//
//  Created by Higor Borjaille on 27/06/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit
import SimpleWizzard

class SampleWizardController: SimpleWizardViewController, CancelDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = UIColor(red: 51/255, green: 64/255, blue: 189/255, alpha: 1)
        self.navigationBar.barStyle = .black
        // End Styling
        
        // Setting the Delegate Cancel
        self.cancelDelegate = self
        
        // Creating the steps
        var viewControllerList = [UIViewController]()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        for i in 0...5 {
            if let controller = mainStoryboard.instantiateViewController(withIdentifier: "sampleStepSID") as? SampleStepViewController {
                controller.pageNumberText = i.description
                viewControllerList.append(controller)
            }
        }
        
        // Setting the images
        self.nextImage = UIImage(named: "right")
        self.prevImage = UIImage(named: "left")
        self.doneImage = UIImage(named: "done_wizzard")
        
        // Setting the color of UIPageDots
        self.pageDots?.currentPageIndicatorTintColor = UIColor.black
        self.pageDots?.pageIndicatorTintColor = UIColor.lightGray
        
        // Generating the SimpleWizard
        self.generate(viewControllerList)
        
        // Setting Title
        self.title = "SampleWizzard"
    }
    
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
