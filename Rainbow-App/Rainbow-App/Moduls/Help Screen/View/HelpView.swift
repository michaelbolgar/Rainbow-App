import UIKit

final class HelpView: UIView {

    //MARK: UI Elements

    private lazy var titleLabel = UILabel.makeLabel(text: "ПРАВИЛА ИГРЫ", font: UIFont.alice(size: 24), textColor: .systemRed)

    private lazy var firstdRulesLabel = UILabel.makeLabelHelpView(text: "На экране в случайном месте появляется слово, обозначающее цвет, например: «‎белый»", font: UIFont.alice(size: 20), textColor: .black)

    private lazy var secondRulesLabel = UILabel.makeLabelHelpView(text: "Нужно произнести вслух цвет, которым написано слово, или цвет подложки: отвечаем «‎синий»", font: UIFont.alice(size: 20), textColor: .black)

    private lazy var thirdRulesLabel = UILabel.makeLabelHelpView(text: "В игре можно изменять скорость от медленной до быстрой, а также длительность игры", font: UIFont.alice(size: 20), textColor: .black)

    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 15
        mainStackView.alignment = .center
        return mainStackView
    }()

    private lazy var substrateDesignationStackView: SubstrateDesignationStackView = {
        let substrateDesignationStackView = SubstrateDesignationStackView()
        return substrateDesignationStackView
    }()

    // MARK: Init
    override init (frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension HelpView {
    
    func drawSelf() {
        addSubview(mainStackView)
        backgroundColor = .white
        layer.cornerRadius = 10
        let mainStackViewConstraints = self.setupMainStackViewConstraints()
        NSLayoutConstraint.activate(mainStackViewConstraints)
        
        mainStackView.addAllArrangedSubviews(titleLabel,
                                             firstdRulesLabel,
                                             substrateDesignationStackView,
                                             secondRulesLabel,
                                             thirdRulesLabel)
    }
    
    func setupMainStackViewConstraints() -> [NSLayoutConstraint] {

        let mainStackViewLeadingInset: CGFloat = 12
        let mainStackViewTrailingInset: CGFloat = -12
        let mainStackViewTopInset: CGFloat = 38
        let mainStackViewBottomInset: CGFloat = -38

        let topAnchor = mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: mainStackViewTopInset)
        let leadingAnchor = mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: mainStackViewLeadingInset)
        let trailingAnchor = mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: mainStackViewTrailingInset)
        let bottomAnchor = mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: mainStackViewBottomInset)
        return [topAnchor,
                leadingAnchor,
                trailingAnchor,
                bottomAnchor]
    }
}
