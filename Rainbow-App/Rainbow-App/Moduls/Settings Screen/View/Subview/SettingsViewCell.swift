//
//  SettingsViewCell.swift
//  Rainbow-App
//
//  Created by dsm 5e on 15.11.2023.
//

import UIKit
import SnapKit

class SettingsViewCell: UITableViewCell {
    
    // MARK: - Cell type
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
    private lazy var cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 15), textColor: .black)
    
    lazy var countLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 22), textColor: .black)
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 2
        slider.isUserInteractionEnabled = true
        return slider
    }()
    
    private lazy var colorGridView: ColorGridView = {
        let colorGridView = ColorGridView()
        return colorGridView
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.isUserInteractionEnabled = true
        return stepper
    }()
    
    private lazy var fontSizeLabel: UILabel = UILabel.makeLabel(font: UIFont.alice(size: 15), textColor: .black)
    
    private lazy var toggler: UISwitch = {
        let toggler = UISwitch()
        toggler.isUserInteractionEnabled = true
        return toggler
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Серый", "Белый", "Черный"])
        segmentedControl.isUserInteractionEnabled = true
        return segmentedControl
    }()
    
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
    
    
    // MARK: -- Init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(cellBackground)
        cellBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        cellBackground.addSubview(hStack)
        cellBackground.addSubview(vStack)
    }
        
    func configure(with title: String, type: SettingsCellType) {
        switch type {
        case .gameTime:
            hStack.addArrangedSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.width.equalTo(130)
            }
            hStack.addArrangedSubview(slider)
            slider.snp.makeConstraints { make in
                make.width.equalTo(100)
            }
            hStack.addArrangedSubview(countLabel)
            titleLabel.text = title
            countLabel.text = "21"
        case .gameSpeed:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(slider)
            titleLabel.numberOfLines = 0
            titleLabel.snp.makeConstraints { make in
                make.width.equalTo(130)
            }
            slider.snp.makeConstraints { make in
                make.width.equalTo(100)
            }
            hStack.addArrangedSubview(countLabel)
            titleLabel.text = title
            countLabel.text = "21"
        case .wordsColor:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(colorGridView)
            colorGridView.snp.makeConstraints { make in
                make.centerY.equalTo(hStack.snp.centerY)
            }
            titleLabel.text = title
        case .fontSize:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(stepper)
            hStack.addArrangedSubview(fontSizeLabel)
            titleLabel.text = title
            fontSizeLabel.text = "Aa"
        case .letterBackground:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(toggler)
            titleLabel.text = title
        case .checkGame:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(toggler)
            titleLabel.text = title
        case .backgroundGameColor:
            vStack.addArrangedSubview(titleLabel)
            vStack.addArrangedSubview(segmentedControl)
            segmentedControl.snp.makeConstraints { make in
                make.leading.trailing.equalTo(vStack)
            }
            titleLabel.text = title
            segmentedControl.selectedSegmentIndex = 0
        }
        
        hStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(cellBackground)
            make.leading.trailing.equalTo(cellBackground).inset(10)
        }
        vStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(cellBackground)
            make.leading.trailing.equalTo(cellBackground).inset(10)
        }
    }
}
