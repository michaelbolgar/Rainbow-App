import UIKit
import SnapKit

class MainVC: UIViewController {

    let mainView = MainView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupView()
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(mainView)

        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

