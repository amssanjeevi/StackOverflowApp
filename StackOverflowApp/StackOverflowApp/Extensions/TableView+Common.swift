//
//  TableView+Common.swift
//  StackOverflowApp
//
//  Created by admin on 08/01/20.
//  Copyright © 2020 Gofrugal Technologies. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerTableCell(for identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func setDefaultsForTableView(hasFooterView: Bool, cellHeight: CGFloat?, headerHeight: CGFloat?, cellSeparatorColor: UIColor?, allowSelection: Bool = true) {
        if (!hasFooterView) {
            tableFooterView = UIView()
        }
        if let cellHeight = cellHeight {
            rowHeight = cellHeight
        }
        if let headerHeight = headerHeight {
            sectionHeaderHeight = headerHeight
        }
        separatorColor = cellSeparatorColor
        allowsSelection = allowSelection
    }
    
    func constructQuestionCell(identifier: String, indexPath: IndexPath, data: AnyObject?) -> QuestionsTableCell {
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! QuestionsTableCell
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        cell.populateView(with: data)
        return cell
    }
}
