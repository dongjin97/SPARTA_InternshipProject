//
//  ViewController.swift
//  InternshipProject
//
//  Created by 원동진 on 8/7/24.
//

// MARK: - import

import UIKit
import SnapKit

// MARK: - LoginViewController

class LoginViewController: UIViewController {
    
    // MARK: - SubViews
    
    private lazy var emailTextField: PaddingTextField = {
        let textField = PaddingTextField()
        textField.placeholder = "이메일을 입력하세요."
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setAddSubViews()
        setAutoLayout()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: - Layout Helpers

extension LoginViewController {
    private func setAddSubViews() {
        view.addSubViews([emailTextField,startButton])
    }
    
    private func setAutoLayout() {
        emailTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(emailTextField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.greaterThanOrEqualTo(view.keyboardLayoutGuide.snp.top).offset(-50)
        }
    }
}
