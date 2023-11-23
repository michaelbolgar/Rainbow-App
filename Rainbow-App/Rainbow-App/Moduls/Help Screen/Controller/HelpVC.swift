import UIKit

final class HelpVC: UIViewController {

    //MARK: UI Elements

    private lazy var scrollView = UIScrollView()

    private lazy var helpView = HelpView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: "Помощь")
        setupUI()
    }

    //MARK: Private Methods

    private func setupUI() {

        view.addSubview(scrollView)
        scrollView.addSubview(helpView)
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = Palette.backgroundBlue

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        helpView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(1100)
        }

        updateBackgroundColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: Notification.Name("ThemeChanged"), object: nil)

    }

    //MARK: Selector Metods

    @objc
    private func updateBackgroundColor() {
        helpView.backgroundColor = ThemeManager.shared.currentBackground
    }
}

