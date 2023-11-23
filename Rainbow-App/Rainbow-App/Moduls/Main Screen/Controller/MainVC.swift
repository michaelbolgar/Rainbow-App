import UIKit

    //MARK: MainView Protocol

protocol MainViewDelegate: AnyObject {
    func didTapNewGame()
    func didTapStatistics()
    func didTapSettings()
    func didTapHelp()
}

class MainVC: UIViewController {

    // MARK: UI Elements

    private let mainView = MainView()

    // MARK: VC Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mainView.delegate = self
    }

    // MARK: Private Methods

    private func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        updateBackgroundColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: Notification.Name("ThemeChanged"), object: nil)
    }

    //MARK: Selector Methods

    @objc
    private func updateBackgroundColor() {
        mainView.backgroundColor = ThemeManager.shared.currentBackground
    }
    
    // MARK: MainVC Extension
}

extension MainVC: MainViewDelegate {
    func didTapNewGame() {
        let viewController = GameVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapStatistics() {
        let viewController = StatisticsVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapSettings() {
        let viewController = SettingsVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTapHelp() {
        let viewController = HelpVC()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

