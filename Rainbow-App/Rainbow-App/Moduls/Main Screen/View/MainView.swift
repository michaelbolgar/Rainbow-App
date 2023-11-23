import Foundation
import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func didTapNewGame()
    func didTapStatistics()
    func didTapSettings()
    func didTapHelp()
}

private extension String {
    static let title = "игра для разминки\nтвоего мозга!"
    static let newGameButton = "Новая игра"
    static let statisticButton = "Статистика"
    static let gearButton = "gearshape.circle"
    static let questionButton = "questionmark.circle"
    static let requiredInit = "init(coder:) has not been implemented"
}

class MainView: UIView {
    
    // MARK: Delegate
    
    weak var delegate: MainViewDelegate?
    
    // MARK: Constants
    
    private let stackSpacing: CGFloat = 15
    private let characterCircleSize: CGFloat = 40
    
    static let shared = MainView()

    // MARK: UI Elements
    
    private lazy var gameLabel: UILabel = {
        let label = UILabel.makeLabel(text: .title,
                                      font: UIFont.caveat(size: 40),
                                      textColor: .white)
        return label
    }()
    lazy var newGameButton: UIButton = {
        let button = UIButton.makeButton(text: .newGameButton)
        button.addTarget(self,
                         action: #selector(didTappedNewGame),
                         for: .touchUpInside)
        return button
    }()
    lazy var statisticButton: UIButton = {
        let button = UIButton.makeButton(text: .statisticButton)
        button.addTarget(self,
                         action: #selector(didTapStatistics),
                         for: .touchUpInside)
        return button
    }()
    lazy var settingsButton: UIButton = {
        let button = UIButton.makeCircleButton(imageName: .gearButton)
        button.addTarget(self,
                         action: #selector(didTapSettings),
                         for: .touchUpInside)
        return button
    }()
    lazy var helpButton: UIButton = {
        let button = UIButton.makeCircleButton(imageName: .questionButton)
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
    private lazy var secondaryButtonsStack = makeStackView(axis: .horizontal,
                                                               spacing: 250,
                                                               views: [settingsButton,
                                                                       helpButton])
    private lazy var mainButtonsStack = makeStackView(axis: .vertical,
                                                               spacing: stackSpacing,
                                                               views: [newGameButton,
                                                                       statisticButton])
    private let colors = [Palette.red, 
                          Palette.orange,
                          Palette.yellow,
                          Palette.green,
                          Palette.blue,
                          Palette.purple]
    private let rainbowWord = ["р", "а", "д", "у", "г", "а"]

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
        setupRainbow()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError(.requiredInit)
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
                characterCircle.configureForRainbow(text: rainbowWord[index], 
                                                    color: color,
                                                    size: characterCircleSize)
                horizontalCharacterslStack.addArrangedSubview(characterCircle)
            }
        }
    
    // MARK: - ObjcDelegate
    
    @objc private func didTappedNewGame() {
        delegate?.didTapNewGame()
    }
    @objc private func didTapStatistics() {
        delegate?.didTapStatistics()
    }
    @objc private func didTapSettings(_ button: UIButton) {
        button.animateButton { [weak self] in
                self?.delegate?.didTapSettings()
            }
    }
    @objc private func didTapHelp(_ button: UIButton) {
        button.animateButton { [weak self] in
                self?.delegate?.didTapHelp()
            }
    }
    
    // MARK: Layout

    private func setupLayout() {

        let screenHeight = UIScreen.main.bounds.height
        let screenThird = screenHeight / 3

        self.addAllTheSubviews(horizontalCharacterslStack,
                               gameLabel,
                               mainButtonsStack,
                               secondaryButtonsStack
        )
        horizontalCharacterslStack.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(screenThird)
            make.centerX.equalToSuperview()
        }
        gameLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCharacterslStack.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        secondaryButtonsStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(50)
            make.centerX.equalToSuperview()
        }
        mainButtonsStack.snp.makeConstraints { make in
            make.bottom.equalTo(secondaryButtonsStack.snp.bottom).inset(80)
            make.centerX.equalToSuperview()
        }
        settingsButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
    }
}

// MARK: - Private+UIButton+Extensions

private extension UIButton {
    static func makeCircleButton(imageName: String = "") -> UIButton {
        let button = UIButton()
        let imageView = UIImageView()
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
    // Reusable method for button animation
    func animateButton(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.alpha = 0.5
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
                self.alpha = 1.0
            }) { _ in
                completion()
            }
        })
    }
}

// MARK: - Private+UILabel+Extensions

private extension UILabel {
    func configureForRainbow(text: String, color: UIColor, size: CGFloat) {
        self.text = text
        self.font = UIFont.russoOne(size: 25)
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
