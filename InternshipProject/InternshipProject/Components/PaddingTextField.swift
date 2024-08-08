//
//  PaddingTextField.swift
//  InternshipProject
//
//  Created by 원동진 on 8/7/24.
//

import UIKit

// MARK: - PaddingTextField

class PaddingTextField : UITextField {
    var textPadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    convenience init(textPadding: UIEdgeInsets) {
        self.init()
        self.textPadding = textPadding
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PaddingTextField {
    func setPlaceholder(text: String) {
        self.placeholder = text
    }
}
