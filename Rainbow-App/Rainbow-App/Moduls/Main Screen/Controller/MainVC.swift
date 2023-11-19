import UIKit

class MainVC: UIViewController {
    
    private let mainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        mainView.delegate = self
    }

    private func setupView() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        updateBackgroundColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: Notification.Name("ThemeChanged"), object: nil)
    }

    //MARK: Selector Metods

    @objc
    private func updateBackgroundColor() {
        mainView.backgroundColor = ThemeManager.shared.currentBackground
    }
    
    // MARK: - MainVC+Extension+Delegate
}

extension MainVC: MainViewDelegate {
    func didTapNewGame() {
        let vc = GameVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapStatistics() {
        let vc = StatisticsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSettings() {
        let vc = SettingsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapHelp() {
        let vc = HelpVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

