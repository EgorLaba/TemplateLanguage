//
//  UITableView+Helper.swift
//  TemplateLanguages
//
//  Created by Егор Лаба on 2/4/21.
//

import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type, for reuseIdentifier: String? = nil) {
        let reuseIdentifier = reuseIdentifier ?? cellType.reuseIdentifier
        let nib = UINib(nibName: String(describing: cellType), bundle: .main)
        
        register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for cell: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as! T
    }
}
