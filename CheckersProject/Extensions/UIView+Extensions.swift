//
//  UIView+Extensions.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 18.11.22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
