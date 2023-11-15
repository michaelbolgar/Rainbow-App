import Foundation
import UIKit
import SnapKit

private extension UIButton {
    static func makeCircleButton(imageName: String = "") -> UIButton {
        let button = UIButton()
        let imageView = UIImageView()
//        button.setImage(UIImage(systemName: imageName), for: .normal)
//        button.snp.makeConstraints { make in
//            make.width.height.equalTo(50)
//        }
        imageView.image = UIImage(systemName: imageName)
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        button.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        return button
    }
}

private extension UILabel {
    func configureForRainbow(text: String, color: UIColor, size: CGFloat) {
        self.text = text
        self.textColor = .black
        self.backgroundColor = color
        self.layer.cornerRadius = size / 2
        self.textAlignment = .center
        self.clipsToBounds = true
        self.snp.makeConstraints { make in
            make.width.height.equalTo(size)
        }
    }
}

class MainView: UIView {
    
    // MARK: Constants
    
    private let stackSpacing: CGFloat = 15
    private let characterCircleSize: CGFloat = 40

    // MARK: UI Elements
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel.makeLabel(text: "игра для разминки\nтвоего мозга!", 
                                      font: UIFont.caveat(size: 40),
                                      textColor: .white)
        return label
    }()
    private lazy var newGameButton: UIButton = {
        let button = UIButton.makeButton(text: "Новая игра")
        button.addTarget(self,
                         action: #selector(didTapNewGame),
                         for: .touchUpInside)
        return button
    }()
    private lazy var statisticButton: UIButton = {
        let button = UIButton.makeButton(text: "Статистика")
        button.addTarget(self,
                         action: #selector(didTapStatistics),
                         for: .touchUpInside)
        return button
    }()
    private lazy var settingsButton: UIButton = {
        let button = UIButton.makeCircleButton(imageName: "gearshape.circle")
        button.addTarget(self,
                         action: #selector(didTapSettings),
                         for: .touchUpInside)
        return button
    }()
    private lazy var helpButton: UIButton = {
        let button = UIButton.makeCircleButton(imageName: "questionmark.circle")
        button.addTarget(self,
                         action: #selector(didTapHelp),
                         for: .touchUpInside)
        return button
    }()
    private lazy var horizontalCharacterslStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = stackSpacing
        return stack
    }()
    
    private lazy var horizontalButtonStack = makeStackView(axis: .horizontal,
                                                               spacing: 250,
                                                               views: [settingsButton,
                                                                       helpButton])
    
    private lazy var verticalalStack = makeStackView(axis: .vertical,
                                                               spacing: stackSpacing,
                                                               views: [newGameButton,
                                                                       statisticButton])

    
    private let colors = [Palette.red, 
                          Palette.orange,
                          Palette.yellow,
                          Palette.green,
                          Palette.blue,
                          Palette.purple
    ]
    private let rainbowWord = ["р", "а", "д", "у", "г", "а"]

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
        setupRainbow()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    
    private func makeStackView(axis: NSLayoutConstraint.Axis, 
                               spacing: CGFloat,
                               views: [UIView] = []) -> UIStackView{
            let stack = UIStackView(arrangedSubviews: views)
            stack.axis = axis
            stack.spacing = spacing
            return stack
        }
    
    private func setupRainbow() {
            for (index, color) in colors.enumerated() {
                let characterCircle = UILabel()
                characterCircle.configureForRainbow(text: rainbowWord[index], color: color, size: characterCircleSize)
                horizontalCharacterslStack.addArrangedSubview(characterCircle)
            }
        }
    
    // MARK: Layout

    private func setupLayout() {
        self.addAllTheSubviews(gameLabel,
                               horizontalCharacterslStack,
                               verticalalStack,
                               horizontalButtonStack
        )
        gameLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCharacterslStack.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        horizontalCharacterslStack.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(292)
            make.centerX.equalToSuperview()
        }
        verticalalStack.snp.makeConstraints { make in
            make.top.equalTo(gameLabel.snp.bottomMargin).offset(120)
            make.centerX.equalToSuperview()
        }
        horizontalButtonStack.snp.makeConstraints { make in
            make.top.equalTo(verticalalStack.snp.bottomMargin).offset(70)
            make.centerX.equalToSuperview()
        }
        settingsButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
    }
    
        // MARK: Router
    
    @objc func didTapNewGame() {
        // Router transition
    }
    @objc func didTapStatistics() {
        // Router transition
    }
    @objc func didTapSettings() {
        // Router transition
    }
    @objc func didTapHelp() {
        // Router transition
    }
}
