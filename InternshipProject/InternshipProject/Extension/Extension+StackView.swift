//
//  Extension+StackView.swift
//  InternshipProject
//
//  Created by 원동진 on 8/8/24.
//

import UIKit

// MARK: - Extension + UIStackView

extension UIStackView{
    func addStackSubViews(_ views : [UIView]){
        _ = views.map{self.addArrangedSubview($0)}
    }
}
