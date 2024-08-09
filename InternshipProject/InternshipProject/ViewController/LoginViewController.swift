//
//  ViewController.swift
//  InternshipProject
//
//  Created by 원동진 on 8/7/24.
//

// MARK: - import

import UIKit
import SnapKit

// MARK: - 초기 화면 LoginViewController

class LoginViewController: UIViewController {
    
    // MARK: - SubViews
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        
        return stackView
    }()
    
    private lazy var emailTextField = makeTextField(placeholderText: "이메일을 입력하세요.")
    private lazy var nameTextField = makeTextField(placeholderText: "이름을 입력하세요.")
    private lazy var nicknameTextField = makeTextField(placeholderText: "닉네임을 입력하세요.")
    
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
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setAddSubViews()
        setAutoLayout()
        isHiddenTextField(hidden: true)
    }
}

// MARK: - Layout Helpers

extension LoginViewController {
    private func setAddSubViews() {
        view.addSubViews([textFieldStackView,startButton])
        textFieldStackView.addStackSubViews([emailTextField,nameTextField,nicknameTextField])
    }
    
    private func setAutoLayout() {
        textFieldStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(15)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(emailTextField.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.greaterThanOrEqualTo(view.keyboardLayoutGuide.snp.top).offset(-50)
        }
    }
}

// MARK: - Private func

extension LoginViewController {
    
    private func isOnlyWhitespace(text: String) -> Bool { // 공백 입력 체크
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func checkTextFieldWhitespace() -> Bool{ // 입력되지 않은 텍스트필드 알림 및 포커스
        let emailCheck = isOnlyWhitespace(text: emailTextField.text ?? "")
        let nameCheck = isOnlyWhitespace(text: nameTextField.text ?? "")
        let nicknameCheck = isOnlyWhitespace(text: nicknameTextField.text ?? "")
        
        if !emailCheck && !nameCheck && !nicknameCheck {
            print("올바른 입력값이 입력 되었습니다.")
            
            return true
        } else {
            if emailCheck {
                focusAndAlert(textField: emailTextField, message: "이메일 입력칸이 공백입니다.")
            } else if nameCheck {
                focusAndAlert(textField: nameTextField, message: "이름 입력칸이 공백입니다.")
            } else if nicknameCheck {
                focusAndAlert(textField: nicknameTextField, message: "닉네임 입력칸이 공백입니다.")
            }
        }
        return false
    }
    
    private func makeTextField(placeholderText: String) -> PaddingTextField {
        let textField = PaddingTextField()
        textField.setPlaceholder(text: placeholderText)
        textField.delegate = self
        
        return textField
    }
    
    private func isHiddenTextField(hidden: Bool) {
        nameTextField.isHidden = hidden
        nicknameTextField.isHidden = hidden
    }
    
    private func presentHomeViewController(email: String) {
        let viewController = HomeViewController()
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.email = email 
        initTextField()
        present(viewController, animated: true)
    }
    
    private func focusAndAlert(textField: UITextField, message: String) { // 입력 오류 알림, 빈칸 포커스 기능
        showMessage(title: "입력 오류", message: message)
        textField.becomeFirstResponder()
    }
    
    private func initTextField() {
        emailTextField.text = ""
        nameTextField.text = ""
        nicknameTextField.text = ""
    }
}

// MARK: - Action

extension LoginViewController {
    @objc private func tapStartButton() {
        let email = emailTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let nickname = nicknameTextField.text ?? ""
        print("typing Email: \(email), name: \(name), nickname: \(nickname)")
        do {
            let isUserExist = try CoreDataManager.shared.isUserExist(email: email)
            
            if isUserExist {
                print("가입된 이메일입니다. 로그인을 진행합니다.")
                presentHomeViewController(email: email)
            } else {
                print("가입되지 않은 이메일입니다. 회원정보를 저장한후 로그인을 진행합니다.")
                isHiddenTextField(hidden: false)
                showMessage(title: "비회원", message: "이름과 닉네임을 입력해주세요.")
                
                if checkTextFieldWhitespace() {
                    CoreDataManager.shared.addUser(email: email,name: name, nickname: nickname)
                    presentHomeViewController(email: email)
                }
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
