import UIKit

class MainVC: UIViewController {
    
    private let build = MainView.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }

    private func setupView() {
        view.addSubview(build)
        build.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActions() {
        build.newGameButton.addTarget(self,
                                      action: #selector(didTapNewGame),
                                      for: .touchUpInside)
        build.statisticButton.addTarget(self,
                                        action: #selector(didTapStatistics),
                                        for: .touchUpInside)
        build.settingsButton.addTarget(self,
                                       action: #selector(didTapSettings),
                                       for: .touchUpInside)
        build.helpButton.addTarget(self,
                                   action: #selector(didTapHelp),
                                   for: .touchUpInside)
    }
    
    @objc func didTapNewGame() {
        // Handle new game action
    }
    
    @objc func didTapStatistics() {
        // Handle statistics action
    }
    
    @objc func didTapSettings() {
        // Handle settings action
    }
    
    @objc func didTapHelp() {
        // Handle help action
    }
}

