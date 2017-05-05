//
//  Section.swift
//  eSegurado
//
//  Created by Eduardo Motta on 25/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import Foundation
import CurioSwift

class SectionDescription: CellDescription {
    
    var imageName: String!
    var items: [CellDescription]?
    var collapsed: Bool!
    var hidden: Bool!
    var field: Any?
    
    init(title: String,
         detail: String?,
         imageName: String,
         items: [CellDescription]?,
         collapsed: Bool = true,
         cellType: CellType,
         hidden: Bool = false) {
        super.init(title: title, detail: detail)
        
        self.cellType = cellType
        self.collapsed = collapsed
        self.imageName = imageName
        self.hidden = hidden
        
        self.items = items
    }
}
