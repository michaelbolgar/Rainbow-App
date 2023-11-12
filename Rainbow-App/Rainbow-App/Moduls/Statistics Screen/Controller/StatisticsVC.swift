import UIKit
import SnapKit

class StatisticsVC: UIViewController {

    let statisticsView = StatisticsView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupView()
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(statisticsView)

        statisticsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

