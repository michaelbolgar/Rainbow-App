import Foundation
import UIKit

// проработать цвета темы, чтобы было сочетание. Вероятно также менять цвета кнопок
// переписать эту логику на делегата?

final class ThemeManager {

    public enum Index: Int {
        case darkTheme = 0
        case lightTheme = 1
    }

    private let udManager: UserDefaultsManagerProtocol = UserDefaultsManager()

    static let shared = ThemeManager()

    lazy var currentBackground = setBackgroundColor(index: udManager.getInt(forKey: .backgroundColor) ?? 0)

    private func setBackgroundColor(index: Int) -> UIColor {
        switch index {
        case Index.darkTheme.rawValue:
            return UIColor.backgroundBlue
        case Index.lightTheme.rawValue:
            return UIColor.systemGray4
        default:
            return UIColor.backgroundBlue
        }
    }
}
