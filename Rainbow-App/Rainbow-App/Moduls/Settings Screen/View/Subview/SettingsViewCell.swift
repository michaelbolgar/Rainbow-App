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
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var colorGridView: ColorGridView = {
        let colorGridView = ColorGridView()
//        colorGridView.backgroundColor = .systemRed
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
        let segmentedControl = UISegmentedControl(items: ["Синий", "Белый", "Черный"])
        segmentedControl.isUserInteractionEnabled = true
        return segmentedControl
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
//        stack.backgroundColor = .systemRed
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
//        stack.backgroundColor = .systemYellow
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
        contentView.addSubview(hStack)


        //у этого стека неправильно задан лейаут ниже, поэтому он каким-то образом перекрывает всю вью. можешь раскоментить у видеть, что всё жёлтое. Нужно найти причину, почему этот стек лезет на другие ячейки, или убрать его вообще
    }
        
    func configure(with title: String, type: SettingsCellType) {
        switch type {
        case .gameTime:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(countLabel)
            hStack.addArrangedSubview(slider)
            titleLabel.text = title

            titleLabel.snp.makeConstraints { make in
                make.width.equalTo(130)
            }
//            countLabel.snp.makeConstraints { make in
//                make.trailing.equalTo(self).inset(20)
//            }
            slider.snp.makeConstraints { make in
                make.width.equalTo(100)
            }
            slider.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.trailing.equalTo(self).inset(25)
            }

        case .gameSpeed:
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

        case .wordsColor:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(colorGridView)

            titleLabel.text = title

            colorGridView.snp.makeConstraints { make in
                make.top.equalTo(self).inset(20)
                make.trailing.equalTo(self).inset(10)
            }

        case .fontSize:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(stepper)
            hStack.addArrangedSubview(fontSizeLabel)

            titleLabel.text = title
            fontSizeLabel.text = "Aa"

            fontSizeLabel.snp.makeConstraints { make in
                make.trailing.equalTo(self).inset(25)
            }
            stepper.snp.makeConstraints { make in
                make.trailing.equalTo(fontSizeLabel).inset(40)
            }

        case .letterBackground:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(toggler)
            titleLabel.text = title

            toggler.snp.makeConstraints { make in
                make.trailing.equalTo(self).inset(25)
            }

        case .checkGame:
            hStack.addArrangedSubview(titleLabel)
            hStack.addArrangedSubview(toggler)
            titleLabel.text = title

            toggler.snp.makeConstraints { make in
                make.trailing.equalTo(self).inset(25)
            }

        case .backgroundGameColor:
            contentView.addSubview(vStack)
            vStack.addArrangedSubview(titleLabel)
            vStack.addArrangedSubview(segmentedControl)

            titleLabel.text = title
            segmentedControl.selectedSegmentIndex = 0

            vStack.snp.makeConstraints { make in
                make.top.bottom.equalTo(cellBackground).inset(5)
                make.leading.trailing.equalTo(cellBackground).inset(10)
            }

            segmentedControl.snp.makeConstraints { make in
                make.leading.trailing.equalTo(vStack)
            }
        }
        
        hStack.snp.makeConstraints { make in
            make.top.bottom.equalTo(cellBackground)
            make.leading.trailing.equalTo(cellBackground).inset(10)
        }
    }
}
