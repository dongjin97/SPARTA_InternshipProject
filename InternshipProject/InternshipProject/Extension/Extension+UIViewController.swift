//
//  Extension+UIViewController.swift
//  InternshipProject
//
//  Created by 원동진 on 8/7/24.
//

import UIKit

// MARK: - Extension + UIViewController

extension UIViewController {
    func setBackgroundColor() {
        self.view.backgroundColor = .white
    }
    // MARK: - 화면 터치시 키보드 내림 관련 코드
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = true // return 또는 화면 터치로 키보드 내리지 않고 시작하기 버튼 누를 경우 생각해서 true로 변환
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
