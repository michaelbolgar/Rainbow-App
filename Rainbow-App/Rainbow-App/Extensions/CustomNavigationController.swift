//
//  CustomNavigationController.swift
//  Rainbow-App
//
//  Created by Caroline Tikhomirova on 17.11.2023.
//

import UIKit

final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        
//        
//    }
}
