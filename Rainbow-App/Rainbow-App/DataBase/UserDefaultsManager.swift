import UIKit

final class UserDefaultsManager {
    
    private enum Keys {
        static let fetchGame = "fetchGame"
        static let saveGame = "saveGame"
    }
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    static let instance = UserDefaultsManager()
    
    func saveValuesToUserDefaults(_ sliderValue: CGFloat,_ stepperValue: CGFloat,_ toggleValue: Bool) {
        // Save the value of the UISlider
        UserDefaults.standard.set(sliderValue, forKey: "sliderValue")

        // Save the value of the UIStepper
        UserDefaults.standard.set(stepperValue, forKey: "stepperValue")

        // Save the value of the UISwitch
        UserDefaults.standard.set(toggleValue, forKey: "switchValue")

        // Synchronize UserDefaults to make sure the values are saved immediately
        UserDefaults.standard.synchronize()
    }
    
    func setValueForSlider(sliderValue: Int) {
        UserDefaults.standard.set(sliderValue, forKey: "sliderValue")
        UserDefaults.standard.synchronize()
    }

    private func encode(game: Game, key: String) {
        if let encoderData = try? JSONEncoder().encode(game) {
            return userDefaults.set(encoderData, forKey: key)
        }
    }
    
    private func decoder(key: String) -> Game {

        if let decoderData = userDefaults.data(forKey: key) {
            let game = try? JSONDecoder().decode(Game.self, from: decoderData)
            if let currentGame = game {
                return currentGame
            }
        }
        return Game(sliderValue: 1, stepperValue: 1, togglerValue: true)
    }
    
    func fetchGame() -> Game {
        decoder(key: Keys.fetchGame)
    }
    
    func saveGame(game: Game) {
        var game = fetchGame()
        encode(game: game, key: Keys.saveGame)
    }
    
    func fetchSlider() -> Int {
        return UserDefaults.standard.integer(forKey: "sliderValue")
    }
}
