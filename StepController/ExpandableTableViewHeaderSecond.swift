//
//  ExpandableTableViewHeaderSecond.swift
//  eSegurado
//
//  Created by Eduardo Motta on 25/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableTableViewHeaderSecond: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowLabel: UIImageView!
   
    
    @IBInspectable var defaultBackgroundColor: UIColor = UIColor.white
    @IBInspectable var highlightedBackgroundColor: UIColor = Colors.primary
    @IBInspectable var defaultFontColor: UIColor = UIColor.black
    @IBInspectable var highlightedFontColor: UIColor = UIColor.white
    @IBInspectable var defaultArrowColor: UIColor = Colors.primary
    @IBInspectable var highlightedArrowColor: UIColor = UIColor.white
    
    var delegate: ExpandableTableViewHeaderDelegate?
    var sectionId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.arrowLabel.image = UIImage(named:"arrow")
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ExpandableTableViewHeaderSecond.tapHeader(_:))))
    }

    
    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        if let cell = gestureRecognizer.view as? ExpandableTableViewHeaderSecond  {
            delegate?.toggleSection(self, section: cell.sectionId)
        }
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation and color change
        //
        let transform = collapsed ?
            CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0) :
            CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
        
        let newBackgroundColor = collapsed ?  defaultBackgroundColor: highlightedBackgroundColor
        let newTitleFontColor = collapsed ? defaultFontColor : highlightedFontColor
        let newTintColor = collapsed ? defaultArrowColor: highlightedArrowColor
        
        //UIView.animate(withDuration: 0.3, animations: {
            self.arrowLabel.transform = transform
            self.contentView.backgroundColor = newBackgroundColor
            self.titleLabel.textColor = newTitleFontColor
            self.arrowLabel.tintColor = newTintColor
            
        //})
        
    }


}
