//
//  UITableViewCell+Helper.swift
//  TemplateLanguages
//
//  Created by Егор Лаба on 2/4/21.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}
