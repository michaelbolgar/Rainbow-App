import UIKit

//поправить вёрстку для SE

final class HelpView: UIView {

    //MARK: UI Elements

    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 10
        return backgroundView
    }()

    private lazy var titleLabel = UILabel.makeLabel(text: "ПРАВИЛА ИГРЫ", font: UIFont.alice(size: 24), textColor: .systemRed)

    private lazy var firstdRulesLabel = UILabel.makeLabelHelpView(text: "На экране в случайном месте появляется слово, обозначающее цвет, например: «‎белый»", font: UIFont.alice(size: 20), textColor: .black)

    private lazy var withBack = UILabel.makeLabel(text: "с подложкой", font: UIFont.alice(size: 12), textColor: .black)

    private lazy var withoutBack = UILabel.makeLabel(text: "без подложки", font: UIFont.alice(size: 12), textColor: .black)

    private lazy var whiteWord = UILabel.makeLabel(text: "белый", font: UIFont.alice(size: 20), textColor: Palette.blue)

    private lazy var circleView = ColorsPatternView(title: "белый", color: Palette.blue, background: true)

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
        self.backgroundColor = Palette.backgroundBlue
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Private Methods

    private func setupUI() {

        let outSideOffset: CGFloat = 34
        let inSideOffset: CGFloat = 20

        self.addSubview(backgroundView)
        [titleLabel, firstdRulesLabel, secondRulesLabel, thirdRulesLabel, withBack, withoutBack, whiteWord, circleView].forEach { backgroundView.addSubview($0) }

        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(180)
            make.bottom.equalToSuperview().inset(120)
            make.leading.trailing.equalToSuperview().inset(outSideOffset)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(inSideOffset)
        }

        [firstdRulesLabel, secondRulesLabel, thirdRulesLabel].forEach {
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(inSideOffset)
            }
        }

        firstdRulesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(outSideOffset + 6)
        }

        withBack.snp.makeConstraints { make in
            make.top.equalTo(firstdRulesLabel.snp.bottom).offset(inSideOffset)
            make.leading.equalToSuperview().offset(inSideOffset * 2.5)
        }

        withoutBack.snp.makeConstraints { make in
            make.top.equalTo(firstdRulesLabel.snp.bottom).offset(inSideOffset)
            make.trailing.equalToSuperview().inset(inSideOffset * 2.5)
        }

        whiteWord.snp.makeConstraints { make in
            make.centerY.equalTo(circleView.snp.centerY)
            make.centerX.equalTo(withBack.snp.centerX)
        }

        circleView.snp.makeConstraints { make in
            make.top.equalTo(firstdRulesLabel.snp.bottom).offset(90)
            make.centerX.equalTo(withoutBack.snp.centerX)
        }

        secondRulesLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).offset(outSideOffset * 2)
        }

        thirdRulesLabel.snp.makeConstraints { make in
            make.top.equalTo(secondRulesLabel.snp.bottom).offset(inSideOffset)
        }

    }

}
