import UIKit
import SnapKit

class SettingsViewCell: UITableViewCell {

    private let udManager: UserDefaultsManagerProtocol = UserDefaultsManager()

    // MARK: - Cell types
    enum SettingsCellType {
        case gameTime
        case gameSpeed
        case wordsColor
        case fontSize
        case letterOrBackground
        case checkGame
        case backgroundGameColor
    }
    
    static let identifier = SettingsViewCell.description()
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 15), textColor: .black)

    private lazy var gameDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "\(udManager.getInt(forKey: .gameDuration) ?? 2)"
        label.font = UIFont.alice(size: 22)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var gameDurationSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.isUserInteractionEnabled = true
        slider.value = Float(udManager.getInt(forKey: .gameDuration) ?? 2)
        slider.addTarget(self, action: #selector(gameDurationAction), for: .valueChanged)
        return slider
    }()
    
    private lazy var colorGridView: ColorGridView = {
        let colorGridView = ColorGridView()
        return colorGridView
    }()
    
    private lazy var fontSizeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.isUserInteractionEnabled = true
        stepper.minimumValue = 18
        stepper.maximumValue = 25
        stepper.value = Double(udManager.getInt(forKey: .fontSize) ?? 20)
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()

    private lazy var fontSizeLabel = UILabel.makeLabel(text: "Aa", font: UIFont.alice(size: CGFloat ( udManager.getInt(forKey: .fontSize) ?? 20)), textColor: .black)
    
    private lazy var isWithBackgroundToggler: UISwitch = {
        let toggler = UISwitch()
        toggler.isUserInteractionEnabled = true
        toggler.addTarget(self, action: #selector(isWithBackgroundAction(_:)), for: .valueChanged)
        return toggler
    }()
    
    lazy var isCheckToggler: UISwitch = {
        let toggler = UISwitch()
        toggler.isUserInteractionEnabled = true
        toggler.addTarget(self, action: #selector(isWithCheckAction(_:)), for: .valueChanged)
        return toggler
    }()

    private lazy var backgroundController = UISegmentedControl.makeController(segments: 2, item1: "Тёмный", item2: "Светлый", item3: nil, item4: nil)

    private lazy var speedController = UISegmentedControl.makeController(segments: 3, item1: "Медленно", item2: "Средне", item3: "Быстро", item4: nil)
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()

    // MARK: - Init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        setupCell()
        setupSegmentedControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods

    private func setupSegmentedControllers() {
        speedController.selectedSegmentIndex = 0
        backgroundController.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        backgroundController.selectedSegmentIndex = udManager.getInt(forKey: .backgroundColor) ?? 0
    }

    private func setupCell() {
        contentView.addSubview(hStack)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    func configure(with title: String, type: SettingsCellType) {
        
        hStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.leading.equalTo(self).inset(20)
            make.trailing.trailing.equalTo(self).inset(25)
        }
        
        switch type {
        case .gameTime:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(gameDurationSlider)
            hStack.addArrangedSubview(gameDurationLabel)
            
            titleLabel.numberOfLines = 0
            titleLabel.text = title
            
            gameDurationLabel.snp.makeConstraints { make in
                make.trailing.equalTo(self).inset(25)
            }
            
            gameDurationSlider.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.trailing.equalTo(gameDurationLabel).inset(40)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(-15)
            }
            
        case .gameSpeed:
            
            contentView.addSubview(vStack)
            vStack.addArrangedSubview(titleLabel)
            vStack.addArrangedSubview(speedController)
            
            titleLabel.text = title

            vStack.snp.makeConstraints { make in
                make.top.bottom.equalTo(self).inset(13)
                make.leading.trailing.equalTo(self).inset(15)
            }
            
            speedController.snp.makeConstraints { make in
                make.leading.trailing.equalTo(vStack)
            }
            
        case .wordsColor:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(colorGridView)
            
            titleLabel.text = title
            
            colorGridView.snp.makeConstraints { make in
                make.top.equalTo(self).inset(20)
                make.trailing.equalTo(self).offset(5)
            }
            
        case .fontSize:
            contentView.addSubview(titleLabel)
            contentView.addSubview(fontSizeStepper)
            contentView.addSubview(fontSizeLabel)
            
            titleLabel.text = title
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
            }
            
            fontSizeLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(20)
            }
            
            fontSizeStepper.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalTo(fontSizeLabel).inset(38)
            }
            
        case .letterOrBackground:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(isWithBackgroundToggler)
            titleLabel.text = title
            isWithBackgroundToggler.isOn = udManager.getBool(forKey: .isWithBackground) ?? false
            
        case .checkGame:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(isCheckToggler)
            titleLabel.text = title
            isCheckToggler.isOn = udManager.getBool(forKey: .isWithCheck) ?? false
            
        case .backgroundGameColor:
            contentView.addSubview(vStack)
            vStack.addArrangedSubview(titleLabel)
            vStack.addArrangedSubview(backgroundController)
            
            titleLabel.text = title
            backgroundController.selectedSegmentIndex = udManager.getInt(forKey: .backgroundColor) ?? 0

            vStack.snp.makeConstraints { make in
                make.top.bottom.equalTo(self).inset(13)
                make.leading.trailing.equalTo(self).inset(15)
            }
            
            backgroundController.snp.makeConstraints { make in
                make.leading.trailing.equalTo(vStack)
            }
        }
    }

    //MARK: Selector Methods

    @objc
    private func gameDurationAction(_ sender: UISlider) {
        let newValue = Int(sender.value)
        print (newValue)
        gameDurationLabel.text = "\(newValue)"
        udManager.set(newValue, forKey: .gameDuration)
    }

    @objc
    private func stepperValueChanged(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        fontSizeLabel.font = UIFont.systemFont(ofSize: fontSize)
        udManager.set(fontSize, forKey: .fontSize)
    }
    
    @objc
    private func isWithBackgroundAction(_ sender: UISwitch) {
        let switchStatus = sender.isOn
        udManager.set(switchStatus, forKey: .isWithBackground)
    }
    
    @objc
    func isWithCheckAction(_ sender: UISwitch) {
        let switchStatus = sender.isOn
        udManager.set(switchStatus, forKey: .isWithCheck)
    }

    @objc
    private func segmentedControlValueChanged() {
        switch backgroundController.selectedSegmentIndex {
        case 0:
            ThemeManager.shared.currentBackground = Palette.backgroundBlue
            udManager.set(backgroundController.selectedSegmentIndex, forKey: .backgroundColor)
        case 1:
            ThemeManager.shared.currentBackground = UIColor.systemGray4
            udManager.set(backgroundController.selectedSegmentIndex, forKey: .backgroundColor)
        default:
            break
        }

        NotificationCenter.default.post(name: Notification.Name("ThemeChanged"), object: nil)
    }
}
