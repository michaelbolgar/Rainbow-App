import Foundation

// проработать цвета темы, чтобы было сочетание. Вероятно также менять цвета кнопок
// переписать эту логику на делегата?

class ThemeManager {

    static let shared = ThemeManager()

    var currentBackground = Palette.backgroundBlue

}
