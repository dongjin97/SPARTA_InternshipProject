//
//  Extension+View.swift
//  InternshipProject
//
//  Created by 원동진 on 8/7/24.
//

import UIKit

// MARK: - Extension + UIViewController

extension UIView {
    func addSubViews(_ views : [UIView]) {
        _ = views.map { self.addSubview($0) }
    }
}
