//
//  HomeViewController.swift
//  InternshipProject
//
//  Created by 원동진 on 8/8/24.
//

// MARK: - import

import UIKit
import SnapKit

// MARK: - 로그인 진행후 화면 HomeViewController

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var email: String?
    
    // MARK: - SubViews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = "test"
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        
        return stackView
    }()
    
    private lazy var backButton = makeButton(title: "뒤로가기", backgroundColor: .systemCyan)
    private lazy var removeAccountButton = makeButton(title: "회원탈퇴",backgroundColor: .systemRed)
    private lazy var logoutButton = makeButton(title: "로그아웃",backgroundColor: .systemGray)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setAddSubViews()
        setAutoLayout()
        setTitleLabel()
        setButtonAction()
    }
}

// MARK: - Layout Helpers

extension HomeViewController {
    private func setAddSubViews() {
        view.addSubViews([titleLabel,buttonStackView])
        buttonStackView.addStackSubViews([backButton,logoutButton,removeAccountButton])
    }
    
    private func setAutoLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
}

// MARK: - Private func

extension HomeViewController {
    private func makeButton(title: String,backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }
    private func setTitleLabel() {
        do {
            let userInfo = try CoreDataManager.shared.getUserInfo(email: email ?? "")
            guard let name = userInfo?.name,
                  let nickname = userInfo?.nickname else { return }
            titleLabel.text = "\(name)/\(nickname) 님 환영합니다."
        } catch {
            print(error)
        }
    }
    
    private func setButtonAction() {
        backButton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        removeAccountButton.addTarget(self, action: #selector(tapRemoveAccountButton), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
    }
}

// MARK: - Action

extension HomeViewController {
    @objc private func tapBackButton() {
        dismiss(animated: true)
    }
    @objc private func tapRemoveAccountButton() {
        do {
            try CoreDataManager.shared.removeUserAccount(email: email ?? "")
        } catch {
            print(error)
        }
        dismiss(animated: true)
    }
    @objc private func tapLogoutButton() {
        titleLabel.text = "로그인 해주세요."
    }
}

