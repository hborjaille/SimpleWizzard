//
//  AutomobilExpandableTableViewHeader.swift
//  Expandable_Table_View
//
//  Created by Eduardo Motta on 18/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

protocol ExpandableTableViewHeaderDelegate {
    func toggleSection(_ header: UITableViewCell, section: Int)
}

class ExpandableTableViewHeaderFirst: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var arrowLabel: UIImageView!
    
    @IBInspectable var defaultBackgroundColor: UIColor = UIColor.white
    @IBInspectable var highlightedBackgroundColor: UIColor = Colors.primary
    var delegate: ExpandableTableViewHeaderDelegate?
    var sectionId: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Creates a line over the header
        let topBorder = UIView()
        topBorder.frame = CGRect( x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 1)
        contentView.addSubview(topBorder)
        topBorder.backgroundColor = Colors.primary
        
        self.arrowLabel.image = UIImage(named:"arrow")
        self.titleLabel.textColor = Colors.secondaryText
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ExpandableTableViewHeaderFirst.tapHeader(_:))))
    }
    
    //
    // Trigger toggle section when tapping on the header
    //
    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? ExpandableTableViewHeaderFirst else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.sectionId)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation and color change
        //
        let transform = collapsed ?
            CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0) :
            CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
        
        let newBackgroundColor = collapsed ?  defaultBackgroundColor: highlightedBackgroundColor
        let newTitleFontColor = collapsed ? Colors.secondaryText : UIColor.white
        let newTintColor = collapsed ? highlightedBackgroundColor: defaultBackgroundColor
        
        //UIView.animate(withDuration: 0.3, animations: {
            self.arrowLabel.transform = transform
            self.contentView.backgroundColor = newBackgroundColor
            self.titleLabel.textColor = newTitleFontColor
            self.imageLabel.tintColor = newTintColor
            self.arrowLabel.tintColor = newTintColor
            
        //})
        
    }
}
