import UIKit

class MainVC: UIViewController {
    
    private let build = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        build.delegate = self
    }

    private func setupView() {
        view.addSubview(build)
        build.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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

