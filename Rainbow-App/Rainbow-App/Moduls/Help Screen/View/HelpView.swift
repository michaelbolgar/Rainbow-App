import UIKit

final class HelpView: UIView {
    
    enum Constants {
        static let mainRulesLabelText = "ПРАВИЛА ИГРЫ"
        static let firstRulesLabelText = "На экране в случайном месте появляется слово, обозначающее цвет, например: «‎\(colorText)»"
        static let secondRulestLabelText = "Нужно произнести вслух цвет, которым написано слово, или цвет подложки: отвечаем синий"
        static let thirdRulesLabelText = "В игре можно изменять скорость от 1х до 5х, а также длительность игры"
        static let colorText = "белый"
        
        static let mainStackViewLeadingInset: CGFloat = 15
        static let mainStackViewTrailingInset: CGFloat = -15
        static let mainStackViewTopInset: CGFloat = 38
        static let mainStackViewBottomInset: CGFloat = -38
    }
    
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.backgroundColor = .white
        mainStackView.distribution = .equalSpacing
        mainStackView.spacing = 15
        mainStackView.alignment = .center
        return mainStackView
    }()
    
    private lazy var mainRulesLabel: UILabel = {
        let mainRulesLabel = UILabel()
        mainRulesLabel.text = Constants.mainRulesLabelText
        mainRulesLabel.textColor = .red
        mainRulesLabel.font = .alice(size: 24) ?? .systemFont(ofSize: 24)
        return mainRulesLabel
    }()
    
    private lazy var firstdRulesLabel: UILabel = {
        let firstRulesLabel = UILabel()
        firstRulesLabel.text = Constants.firstRulesLabelText
        firstRulesLabel.numberOfLines = 4
        firstRulesLabel.font = .alice(size: 20) ?? .systemFont(ofSize: 20)
        return firstRulesLabel
    }()
    
    private lazy var substrateDesignationStackView: SubstrateDesignationStackView = {
        let substrateDesignationStackView = SubstrateDesignationStackView()
        return substrateDesignationStackView
    }()
    
    private lazy var secondRulesLabel: UILabel = {
        let secondRulesLabel = UILabel()
        secondRulesLabel.text = Constants.secondRulestLabelText
        secondRulesLabel.font = .alice(size: 20) ?? .systemFont(ofSize: 20)
        secondRulesLabel.numberOfLines = 4
        return secondRulesLabel
    }()
    
    private lazy var thirdRulesLabel: UILabel = {
        let thirdRulesLabel = UILabel()
        thirdRulesLabel.text = Constants.thirdRulesLabelText
        thirdRulesLabel.font = .alice(size: 20) ?? .systemFont(ofSize: 20)
        thirdRulesLabel.numberOfLines = 3
        return thirdRulesLabel
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
        
        mainStackView.addAllArrangedSubviews(mainRulesLabel,
                                             firstdRulesLabel,
                                             substrateDesignationStackView,
                                             secondRulesLabel,
                                             thirdRulesLabel)
    }
    
    func setupMainStackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.mainStackViewTopInset)
        let leadingAnchor = mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.mainStackViewLeadingInset)
        let trailingAnchor = mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.mainStackViewTrailingInset)
        let bottomAnchor = mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.mainStackViewBottomInset)
        return [topAnchor,
                leadingAnchor,
                trailingAnchor,
                bottomAnchor]
    }
}
