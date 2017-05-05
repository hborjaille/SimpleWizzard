//
//  ExpandableTableViewSubheader.swift
//  Expandable_Table_View
//
//  Created by Eduardo Motta on 19/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableTableViewCellThird: UITableViewCell {
    
    @IBOutlet weak var titleFirstLabel: UILabel!
    @IBOutlet weak var titleSecondLabel: UILabel!
    @IBOutlet weak var titleThirdLabel: UILabel!
    
    @IBOutlet weak var detailFirstLabel: UILabel!
    @IBOutlet weak var detailSecondLabel: UILabel!
    @IBOutlet weak var detailThirdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
