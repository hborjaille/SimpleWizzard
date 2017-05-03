//
//  EmptyState.swift
//  eSegurado
//
//  Created by Higor Borjaille on 12/04/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

public class EmptyState {
    
    var overlayView = UIView()
    var imageView = UIImageView()
    var labelView = UILabel()
    
    func addConstraints(_ view: UIView) {
        
        view.addSubview(overlayView)
        
        
        // Styling
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let frameSizeSide = height > width ? height : width
    
        overlayView.backgroundColor = UIColor.white
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            overlayView.widthAnchor.constraint(equalToConstant: frameSizeSide),
            overlayView.heightAnchor.constraint(equalToConstant: frameSizeSide),
        ])

        imageView.image = UIImage(named: "empty_state")
        imageView.image = imageView.image?.maskWithColor(color: Colors.primary)
        
        labelView.textColor = Colors.secondaryText
        labelView.textAlignment = .center
        labelView.numberOfLines = 3
        
        let stackView = UIStackView(arrangedSubviews: [imageView, labelView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        overlayView.addSubview(stackView)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            // It's an iPhone
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: width * 0.4),
                imageView.heightAnchor.constraint(equalToConstant: width * 0.4)
                ])
        case .pad:
            // It's an iPad
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: width * 0.2),
                imageView.heightAnchor.constraint(equalToConstant: width * 0.2)
            ])
        default: break
        }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor, constant: 0),
            stackView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor, constant: 0)
        ])
        // Styling
        
    }
    
    public func show(view: UIView, message: String) {
        labelView.text = message
        addConstraints(view)
    }
    
    public func hide() {
        self.overlayView.removeFromSuperview()
    }
}
