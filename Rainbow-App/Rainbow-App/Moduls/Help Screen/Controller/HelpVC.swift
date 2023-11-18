import UIKit

final class HelpVC: UIViewController {

    //MARK: UI Elements

    private lazy var helpView: HelpView = {
        let helpView = HelpView()
        helpView.translatesAutoresizingMaskIntoConstraints = false
        return helpView
    }()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Помощь")
        setupUI()
    }

    //MARK: Private Methods

    private func setupUI() {

        view.addSubview(helpView)

        helpView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}

