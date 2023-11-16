import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow (windowScene: windowScene)

        window.rootViewController = MainVC()
//        window.rootViewController = UINavigationController(rootViewController: GameVC())
//        window.rootViewController = StatisticsVC()
//        window.rootViewController = MainVC()
//        window.rootViewController = UINavigationController(rootViewController: GameVC())
//         window.rootViewController = StatisticsVC()
//        window.rootViewController = SettingsVC()
//        window.rootViewController = HelpVC()

        window.makeKeyAndVisible()
        self.window = window
    }
}
