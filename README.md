# SimpleWizzard

[![CI Status](http://img.shields.io/travis/hborjaille/SimpleWizzard.svg?style=flat)](https://travis-ci.org/hborjaille/SimpleWizzard)
[![Version](https://img.shields.io/cocoapods/v/SimpleWizzard.svg?style=flat)](http://cocoapods.org/pods/SimpleWizzard)
[![License](https://img.shields.io/cocoapods/l/SimpleWizzard.svg?style=flat)](http://cocoapods.org/pods/SimpleWizzard)
[![Platform](https://img.shields.io/cocoapods/p/SimpleWizzard.svg?style=flat)](http://cocoapods.org/pods/SimpleWizzard)

![alt text](https://media.giphy.com/media/xNf8g0un4MjdK/giphy.gif)

## Requirements

iOS 9+

## Installation

SimpleWizzard is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SimpleWizzard"
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Code Examples
#### Creating a ViewController that will be encapsulated on SimpleWizzard

This controller needs to implement ChangeStepDelegate that will tell the Wizzard when to change the Step or not.


``` swift
import SimpleWizzard

class SampleStepViewController: UIViewController, ChangeStepDelegate {

    func verifyNext() -> Bool {
        SampleWizardController.wizardInstance?.next()
        return false
    }
    
    func verifyPrev() -> Bool {
        return true
    }
}
```

##### There are two ways to use it

Return false into veryfyNext() function and force the changing

``` swift
func verifyNext() -> Bool {
    SampleWizardController.wizardInstance?.next()
    return false
}
```

Or simply returning true on the function

``` swift
func verifyNext() -> Bool {
    return true
}
```
The same applies for changing from current to previous ViewController.

#### Creating a ViewController extending from SimpleWizzardViewController

The created class has to implement CancelDelegate. This class will be responsible for canceling the wizzard progress. The user needs to instantiate every ViewController that it wants to use, before use the function generate.

``` swift
import SimpleWizzard

class SampleWizardController: SimpleWizardViewController, CancelDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        self.title = "SimpleWizzard"
    }
    
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
```

## Author

Higor Borjaille

E-mail: higor.borjaille@gmail.com

## License

SimpleWizzard is available under the MIT license. See the LICENSE file for more info.
