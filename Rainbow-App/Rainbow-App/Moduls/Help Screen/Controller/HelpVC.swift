import UIKit

final class HelpVC: UIViewController {
    
    enum Constants {
        static let helpViewTopInset: CGFloat = 160
        static let helpViewLeadingInset: CGFloat = 38
        static let helpViewTrainilingInset: CGFloat = -38
        static let helpViewBottomInset: CGFloat = -130
        
        static let titleString = "Помощь"
    }

    private lazy var helpView: HelpView = {
        let helpView = HelpView()
        helpView.translatesAutoresizingMaskIntoConstraints = false
        return helpView
    }()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
}

//MARK: HelpViewController's methods
private extension HelpVC {
    
    func drawSelf() {
        view.backgroundColor = Palette.backgroundBlue
        view.addSubview(helpView)
        let helpViewConstraints = self.setupHelpViewsConstraints()
        NSLayoutConstraint.activate(helpViewConstraints)
        setNavigationController(title: Constants.titleString)
    }
    
    func setupHelpViewsConstraints() -> [NSLayoutConstraint] {
        
        let topAnchor = helpView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.helpViewTopInset)
        let leadingAnchor = helpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.helpViewLeadingInset)
        let trailingAnchor = helpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.helpViewTrainilingInset)
        let bottomAnchor = helpView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.helpViewBottomInset)
        return [topAnchor,
                leadingAnchor,
                trailingAnchor,
                bottomAnchor]
    }
}

