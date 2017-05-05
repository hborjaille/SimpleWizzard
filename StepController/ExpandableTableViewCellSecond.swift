//
//  ExpandableTableViewCellSecond.swift
//  eSegurado
//
//  Created by Higor Borjaille on 01/02/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class ExpandableTableViewCellSecond: UITableViewCell {
    
    @IBOutlet weak var titleFirstLabel: UILabel!
    @IBOutlet weak var detailFirstLabel: UILabel!
    @IBOutlet weak var titleSecondLabel: UILabel!
    @IBOutlet weak var detailSecondLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
