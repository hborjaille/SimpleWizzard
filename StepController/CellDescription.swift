//
//  CustomCell.swift
//  Expandable_Table_View
//
//  Created by Eduardo Motta on 18/01/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit

class CellDescription {

    var title: String?
    var detail: String?
    var titleSecond: String?
    var detailSecond: String?
    var titleThird: String?
    var detailThird: String?
    var cellType: CellType
    
    init(title: String?, detail: String?, titleSecond: String? = nil, detailSecond: String? = nil, titleThird: String? = nil, detailThird: String? = nil) {
        self.title = title
        self.detail = detail
        self.titleSecond = titleSecond
        self.detailSecond = detailSecond
        self.titleThird = titleThird
        self.detailThird = detailThird
        self.cellType = CellType.cellFirst
        
        if (title != nil || detail != nil)  && (titleSecond != nil || detailSecond != nil) {self.cellType = CellType.cellSecond}
        if (title != nil || detail != nil)  && (titleSecond != nil || detailSecond != nil) && (titleThird != nil || detailThird != nil) {self.cellType = CellType.cellThird}
    }
    
}

enum CellType {
    case headerFirst // Standard header, aways visible, expansible
    case headerSecond // Can be hidden by a first header, expansible
    case headerThird
    case cellFirst
    case cellSecond
    case cellThird
}
