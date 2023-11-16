import UIKit

class MainVC: UIViewController {
    
    private let build = MainView.shared

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
        // Handle new game action
    }
    
    func didTapStatistics() {
        // Handle statistics action
    }
    
    func didTapSettings() {
        // Handle settings action
    }
    
    func didTapHelp() {
        // Handle help action
    }
}

