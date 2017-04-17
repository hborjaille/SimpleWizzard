//
//  ViewController.swift
//  StepController
//
//  Created by Higor Borjaille on 17/04/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

protocol MovePageDelegate {
    func prev() -> Void
    func next() -> Void
}

class StepViewController: UIViewController, StepPageViewControllerDelegate {

    @IBOutlet weak var pageDots: UIPageControl!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    var delegate: MovePageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pageDots.pageIndicatorTintColor = UIColor(red: 0.7, green: 0.2, blue: 0.8, alpha: 1)
        pageDots.currentPageIndicatorTintColor = UIColor.green
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stepPageViewController(viewController: UIViewController,
                                 didUpdatePageCount count: Int) {
        pageDots.numberOfPages = count
    }
    
    func stepPageViewController(viewController: UIViewController,
                                 didUpdatePageIndex index: Int) {
        pageDots.currentPage = index
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prev()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        delegate?.next()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? StepPageViewController {
            pageViewController.stepDelegate = self
            self.delegate = pageViewController
        }
        
    }

}

