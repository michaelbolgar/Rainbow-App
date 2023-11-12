import UIKit
import SnapKit

class HelpVC: UIViewController {

    let helpView = HelpView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        setupView()
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(helpView)

        helpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

