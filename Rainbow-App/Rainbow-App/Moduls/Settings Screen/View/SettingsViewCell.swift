import UIKit
import SnapKit

class SettingsViewCell: UITableViewCell {
    
    // MARK: - Cell types
    enum SettingsCellType {
        case gameTime
        case gameSpeed
        case wordsColor
        case fontSize
        case letterBackground
        case checkGame
        case backgroundGameColor
    }
    
    static let identifier = SettingsViewCell.description()
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 15), textColor: .black)
    
    lazy var countLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 22), textColor: .black)
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 5
        slider.isUserInteractionEnabled = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var colorGridView: ColorGridView = {
        let colorGridView = ColorGridView()
        return colorGridView
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.isUserInteractionEnabled = true
        stepper.minimumValue = 16
        stepper.maximumValue = 20
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    
    private lazy var fontSizeLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 16), textColor: .black)
    
    private lazy var toggler: UISwitch = {
        let toggler = UISwitch()
        toggler.isUserInteractionEnabled = true
        toggler.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        return toggler
    }()

    private lazy var backgroundController = UISegmentedControl.makeController(segments: 3, item1: "Тёмный", item2: "Светлый", item3: "Мятный", item4: nil)

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
        backgroundController.selectedSegmentIndex = 0
        backgroundController.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)

        speedController.selectedSegmentIndex = 0
    }

    private func setupCell() {
        
        contentView.addSubview(hStack)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        
    }
    
    func setupSegmantConroller() {
        speedController.addTarget(self, action: #selector(speedConrollerChanged(_:)), for: .valueChanged)
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
            hStack.addArrangedSubview(slider)
            hStack.addArrangedSubview(countLabel)
            
            titleLabel.numberOfLines = 0
            titleLabel.text = title
            
            countLabel.snp.makeConstraints { make in
                make.trailing.equalTo(self).inset(25)
            }
            
            slider.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.trailing.equalTo(countLabel).inset(40)
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
            contentView.addSubview(stepper)
            contentView.addSubview(fontSizeLabel)
            
            titleLabel.text = title
            fontSizeLabel.text = "Aa"
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
            }
            
            fontSizeLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(20)
            }
            
            stepper.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalTo(fontSizeLabel).inset(38)
            }
            
        case .letterBackground:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(toggler)
            titleLabel.text = title
            
        case .checkGame:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(toggler)
            titleLabel.text = title
            
        case .backgroundGameColor:
            contentView.addSubview(vStack)
            vStack.addArrangedSubview(titleLabel)
            vStack.addArrangedSubview(backgroundController)
            
            titleLabel.text = title

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
    private func stepperValueChanged(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        fontSizeLabel.font = UIFont.systemFont(ofSize: fontSize)
        UserDefaults.standard.set(Double(fontSize), forKey: "forStepperKey")
    }
    
    @objc
    private func toggleValueChanged(_ sender: UISwitch) {
        let switchStatus = sender.isOn
        UserDefaults.standard.set(switchStatus, forKey: "forToggleKey")
    }
    
    @objc
    private func speedConrollerChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        let speedStatus = sender.titleForSegment(at: selectedIndex)
        UserDefaults.standard.set(speedStatus, forKey: "forSpeedKey")
    }

    @objc
    private func segmentedControlValueChanged() {
        switch backgroundController.selectedSegmentIndex {
        case 0:
            ThemeManager.shared.currentBackground = Palette.backgroundBlue
        case 1:
            ThemeManager.shared.currentBackground = .systemBlue
        case 2:
            ThemeManager.shared.currentBackground = .systemMint
        default:
            break
        }

        NotificationCenter.default.post(name: Notification.Name("ThemeChanged"), object: nil)
    }
}
