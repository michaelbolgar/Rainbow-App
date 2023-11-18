import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow (windowScene: windowScene)

//        let rootVC = SettingsVC()
        let rootVC = HelpVC()
//        let rootVC = MainVC()
        let navigationVC = CustomNavigationController(rootViewController: rootVC)
        window?.rootViewController = navigationVC
        
        window?.makeKeyAndVisible()
        //self.window = window
    }
}
