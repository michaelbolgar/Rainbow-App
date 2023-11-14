//
//  UIViewController.swift
//  Rainbow-App
//
//  Created by Лилия Феодотова on 14.11.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func setNavigationBackButton(title: String) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont.alice(size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .regular)]
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
}
