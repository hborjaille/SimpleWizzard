//
//  ExpandableTableViewSubheader.swift
//  Expandable_Table_View
//
//  Created by Eduardo Motta on 19/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableTableViewHeaderThird: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    //@IBInspectable var defaultBackgroundColor: UIColor = UIColor.white
    //@IBInspectable var fontColor: UIColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.textColor = Colors.primary
        self.titleLabel.backgroundColor = UIColor.white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
