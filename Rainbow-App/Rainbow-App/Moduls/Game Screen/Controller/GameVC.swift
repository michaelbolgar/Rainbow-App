import UIKit
import SnapKit

class GameVC: UIViewController {

    let gameView = GameView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(gameView)

        gameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

