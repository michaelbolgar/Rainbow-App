//
//  RainbowColors.swift
//  Rainbow-App
//
//  Created by Лилия Феодотова on 14.11.2023.
//

import Foundation
import UIKit

enum RainbowColors: String, CaseIterable {
    case red = "красный"
    case pink = "розовый"
    case orange = "оранжевый"
    case yellow = "желтый"
    case green = "зеленый"
    case lightBlue = "голубой"
    case blue = "синий"
    case purple = "фиолетовый"
    case white = "белый"
    
    var color: UIColor {
        switch self{
        case .red:
            return .red
        case .pink:
            return UIColor(red: 0.99, green: 0.13, blue: 0.64, alpha: 1.00)
        case .orange:
            return UIColor.orange
        case .yellow:
            return UIColor.yellow
        case .green:
            return UIColor.green
        case .lightBlue:
            return UIColor(red: 0.26, green: 0.67, blue: 1.00, alpha: 1.00)
        case .blue:
            return UIColor(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)
        case .purple:
            return UIColor.purple
        case .white:
            return .white
        }
    }
}
