import UIKit
import SnapKit

class SettingsVC: UIViewController {

    let settingsView = SettingsView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setupView()
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(settingsView)

        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

