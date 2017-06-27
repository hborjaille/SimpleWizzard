//
//  Extensions.swift
//  StepController
//
//  Created by Higor Borjaille on 27/06/17.
//  Copyright © 2017 Higor Borjaille. All rights reserved.
//

import UIKit

extension UIImage {
    public func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}

extension UIViewController {
    public func presentWithWizard(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if let wizard = SimpleWizardViewController.wizardInstance {
            wizard.present(viewControllerToPresent, animated: flag, completion: completion)
        } else {
            self.present(viewControllerToPresent, animated: flag, completion: completion)
        }
    }
}
