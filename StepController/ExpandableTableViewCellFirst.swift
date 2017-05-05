//
//  CustomTableViewCell.swift
//  Expandable_Table_View
//
//  Created by Eduardo Motta on 18/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableTableViewCellFirst: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
