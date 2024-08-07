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
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tapStartButton), for: .touchUpInside)
        
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

// MARK: - Private Method

extension LoginViewController {
    private func getEmailTextFieldText() -> String? {
        return emailTextField.text
    }
}


// MARK: - Action

extension LoginViewController {
    @objc private func tapStartButton() {
        guard let email = getEmailTextFieldText() else { return }
        print("typing Email: \(email)") // 이메일 아무것도 안쳤을때 분기 생각 !
        do {
            let isUserExit = try CoreDataManager.shared.isUserExist(email:  email)
            if isUserExit {
                print("가입된 이메일입니다. 로그인을 진행합니다.")
            } else {
                print("가입되지 않은 이메일입니다. 회원정보를 저장한후 로그인을 진행합니다.")
                CoreDataManager.shared.addUser(email: email)
            }
        } catch {
            print(error)
        }
    }
}


// MARK: - UITextField Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
