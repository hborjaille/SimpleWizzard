//
//  ExpandableCommonFunctions.swift
//  eSegurado
//
//  Created by Higor Borjaille on 05/05/17.
//  Copyright © 2017 Evológica. All rights reserved.
//

import UIKit
import CurioSwift

class ExpandableCommonTable: UITableViewController {
    
    var sections = [SectionDescription]()
    var policy: Apolice?
    var field: Any?
    var disableToggleSection = false
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Section/Header  cell
        if (indexPath.row == 0) {
            let sectionIndex = indexPath.section
            switch sections[sectionIndex].cellType {
                
            case .headerFirst:
                let sectionCell = tableView.dequeueReusableCell(withIdentifier: "expandableHeaderFirstId" , for: indexPath) as! ExpandableTableViewHeaderFirst
                sectionCell.titleLabel.text = sections[sectionIndex].title
                sectionCell.imageLabel.image = UIImage(named: sections[sectionIndex].imageName)
                //sectionCell.arrowLabel.isHidden = disableToggleSection ? true : false
                sectionCell.sectionId = sectionIndex
                sectionCell.setCollapsed(sections[sectionIndex].collapsed)
                sectionCell.delegate = self
                return sectionCell
                
            case .headerSecond:
                let sectionCell = tableView.dequeueReusableCell(withIdentifier: "expandableHeaderSecondId" , for: indexPath) as! ExpandableTableViewHeaderSecond
                sectionCell.titleLabel.text = sections[sectionIndex].title
                sectionCell.sectionId = sectionIndex
                sectionCell.setCollapsed(sections[sectionIndex].collapsed)
                sectionCell.delegate = self
                return sectionCell
                
            case .headerThird:
                let sectionCell = tableView.dequeueReusableCell(withIdentifier: "expandableHeaderThirdId" , for: indexPath) as! ExpandableTableViewHeaderThird
                sectionCell.titleLabel.text = sections[sectionIndex].title
                return sectionCell
                
            case .cellFirst:
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCellFirstId" , for: indexPath) as! ExpandableTableViewCellFirst
                if let title = sections[sectionIndex].title {
                    cell.titleLabel.isHidden = false
                    cell.titleLabel.text = title
                } else {
                    cell.titleLabel.isHidden = true
                }
                
                cell.detailLabel.text = sections[sectionIndex].detail
                return cell
                
            case .cellSecond:
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCellSecondId" , for: indexPath) as! ExpandableTableViewCellSecond
                cell.titleFirstLabel.text = sections[sectionIndex].title
                cell.detailFirstLabel.text = sections[sectionIndex].detail
                cell.titleSecondLabel.text = sections[sectionIndex].titleSecond
                cell.detailSecondLabel.text = sections[sectionIndex].detailSecond
                return cell
                
            case .cellThird:
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCellThirdId" , for: indexPath) as! ExpandableTableViewCellThird
                cell.titleFirstLabel.text = sections[sectionIndex].title
                cell.detailFirstLabel.text = sections[sectionIndex].detail
                cell.titleSecondLabel.text = sections[sectionIndex].titleSecond
                cell.detailSecondLabel.text = sections[sectionIndex].detailSecond
                cell.titleThirdLabel.text = sections[sectionIndex].titleThird
                cell.detailThirdLabel.text = sections[sectionIndex].detailThird
                return cell
            }
        }
        
        let cellDescription = sections[indexPath.section].items?[indexPath.row-1]
        
        // Other cells
        if  let cellType = cellDescription?.cellType {
            switch cellType {
                
            case .cellFirst:
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCellFirstId" , for: indexPath) as! ExpandableTableViewCellFirst
                testToHideLabel(cell.titleLabel, cellDescription?.title)
                
                cell.detailLabel.text = cellDescription?.detail
                return cell
                
            case .cellSecond:
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCellSecondId" , for: indexPath) as! ExpandableTableViewCellSecond
                testToHideLabel(cell.titleFirstLabel, cellDescription?.title)
                cell.detailFirstLabel.text = cellDescription?.detail
                testToHideLabel(cell.titleSecondLabel, cellDescription?.titleSecond)
                cell.detailSecondLabel.text = cellDescription?.detailSecond
                return cell
                
            case .cellThird:
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCellThirdId" , for: indexPath) as! ExpandableTableViewCellThird
                testToHideLabel(cell.titleFirstLabel, cellDescription?.title)
                cell.detailFirstLabel.text = cellDescription?.detail
                testToHideLabel(cell.titleSecondLabel, cellDescription?.titleSecond)
                cell.detailSecondLabel.text = cellDescription?.detailSecond
                testToHideLabel(cell.titleThirdLabel, cellDescription?.titleThird)
                cell.detailThirdLabel.text = cellDescription?.detailThird
                return cell
                
            default: break
            }
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sections[section].hidden == true {
            return 0
        }
        if sections[section].collapsed == true {
            return 1
        }
        if let items = sections[section].items {
            return items.count+1
        }
        return 0
    }
    
    func testToHideLabel(_ label: UILabel, _ str: String?) {
        if let title = str {
            label.isHidden = false
            label.text = title
        } else {
            label.isHidden = true
        }
    }
}

//
// MARK: - Section Header Delegate
//

extension ExpandableCommonTable: ExpandableTableViewHeaderDelegate {
    
    func toggleSection(_ header: UITableViewCell, section: Int) {
        
        if let header = header as? ExpandableTableViewHeaderFirst {
            if disableToggleSection {
                return
            }
            
            let collapsed = !sections[section].collapsed
            
            // Toggle collapse
            sections[section].collapsed = collapsed
            header.setCollapsed(collapsed)
            
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
            for i in section+1 ..< sections.count {
                let sec = sections[i]
                if sec.cellType == .headerFirst {
                    break
                }
                else {
                    sec.hidden = !sec.hidden
                    tableView.reloadSections(IndexSet(integer: i), with: .automatic)
                }
            }
        }
        
        if let header = header as? ExpandableTableViewHeaderSecond {
            let collapsed = !sections[section].collapsed
            
            // Toggle collapse
            sections[section].collapsed = collapsed
            header.setCollapsed(collapsed)
            
            //tableView.reloadData()
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
    
}
