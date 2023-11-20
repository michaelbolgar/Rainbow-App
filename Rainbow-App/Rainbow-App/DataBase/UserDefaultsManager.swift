import UIKit

    // MARK: CRUD

protocol UserDefaultsManagerProtocol {

    //methods for setting new data
    func set(_ object: Any?, forKey key: UserDefaultsManager.Keys)
    func setCustomType<T: Encodable>(object: T?, forKey key: UserDefaultsManager.Keys)

    //methods for getting saved data
    func getInt(forKey key: UserDefaultsManager.Keys) -> Int?
    func getDouble(forKey key: UserDefaultsManager.Keys) -> Double?
    func getString(forKey key: UserDefaultsManager.Keys) -> String?
    func getBool(forKey key: UserDefaultsManager.Keys) -> Bool?
    func getArray(forKey key: UserDefaultsManager.Keys) -> [Int]
    func getCodableData<T: Decodable>(forKey: UserDefaultsManager.Keys) -> T?

    //deleting data
    func delete(forKey key: UserDefaultsManager.Keys)
}


final class UserDefaultsManager {

    public enum Keys: String {
        case gameDuration = "gameDuration"
        case gameSpeed = "gameSpeed"
        case selectedColors = "selectedColors"
        case fontSize = "fontSize"
        case isWithBackground = "isWithBackground"
        case isWithCheck = "isWithCheck"
        case backgroundColor = "backgroundColor"
    }

    private let userDefaults = UserDefaults.standard

    private func storeData(_ object: Any?, key: String) {
        userDefaults.set(object, forKey: key)
    }

    private func restoreData(forKey key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
}

    //MARK: UserDefaultsManagerProtocol

extension UserDefaultsManager: UserDefaultsManagerProtocol {

    func set(_ object: Any?, forKey key: Keys) {
        storeData(object, key: key.rawValue)
    }

    func setCustomType<T: Encodable>(object: T?, forKey key: Keys) {
        let jsonData = try? JSONEncoder().encode(object)
        storeData(object, key: key.rawValue)
    }

    func getInt(forKey key: Keys) -> Int? {
        restoreData(forKey: key.rawValue) as? Int
    }

    func getDouble(forKey key: Keys) -> Double? {
        restoreData(forKey: key.rawValue) as? Double
    }

    func getString(forKey key: Keys) -> String? {
        restoreData(forKey: key.rawValue) as? String
    }

    func getBool(forKey key: Keys) -> Bool? {
        restoreData(forKey: key.rawValue) as? Bool
    }

    func getArray(forKey key: Keys) -> [Int] {
        restoreData(forKey: key.rawValue) as? [Int] ?? [0, 1, 2]
    }

    func getCodableData<T: Decodable>(forKey key: Keys) -> T? {
        guard let data = restoreData(forKey: key.rawValue) as? Data else { return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func delete(forKey key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
    
//    private init() {}
//
//    static let instance = UserDefaultsManager()
//
//    func saveValuesToUserDefaults(_ sliderValue: CGFloat,_ stepperValue: CGFloat,_ toggleValue: Bool) {
//        // Save the value of the UISlider
//        UserDefaults.standard.set(sliderValue, forKey: "sliderValue")
//
//        // Save the value of the UIStepper
//        UserDefaults.standard.set(stepperValue, forKey: "stepperValue")
//
//        // Save the value of the UISwitch
//        UserDefaults.standard.set(toggleValue, forKey: "switchValue")
//
//        // Synchronize UserDefaults to make sure the values are saved immediately
//        UserDefaults.standard.synchronize()
//    }
//
//    func setValueForSlider(sliderValue: Int) {
//        UserDefaults.standard.set(sliderValue, forKey: "sliderValue")
//        UserDefaults.standard.synchronize()
//    }
//
//    private func encode(game: Game, key: String) {
//        if let encoderData = try? JSONEncoder().encode(game) {
//            return userDefaults.set(encoderData, forKey: key)
//        }
//    }
//
//    private func decoder(key: String) -> Game {
//
//        if let decoderData = userDefaults.data(forKey: key) {
//            let game = try? JSONDecoder().decode(Game.self, from: decoderData)
//            if let currentGame = game {
//                return currentGame
//            }
//        }
//        return Game(sliderValue: 1, stepperValue: 1, togglerValue: true)
//    }
//
//    func fetchGame() -> Game {
//        decoder(key: Keys.fetchGame)
//    }
//
//    func saveGame(game: Game) {
//        var game = fetchGame()
//        encode(game: game, key: Keys.saveGame)
//    }
//
//    func fetchSlider() -> Int {
//        return UserDefaults.standard.integer(forKey: "sliderValue")
//    }
