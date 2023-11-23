import Foundation
import UIKit
import SnapKit

class MainView: UIView {
    
    // MARK: Delegate
    
    weak var delegate: MainViewDelegate?
    
    // MARK: Constants
    
    private let stackSpacing: CGFloat = 15
    private let characterCircleSize: CGFloat = 40

    private let colors = [UIColor.red,
                          UIColor.orange,
                          UIColor.yellow,
                          UIColor.green,
                          UIColor.blue,
                          UIColor.purple]

    private let rainbowWord = ["р", "а", "д", "у", "г", "а"]

    // MARK: UI Elements

    private lazy var gameLabel = UILabel.makeLabel(text: "игра для разминки\nтвоего мозга!", font: UIFont.caveat(size: 40), textColor: .white)

    private lazy var newGameButton: UIButton = {
        let button = UIButton.makeButton(text: "Новая игра")
        button.addTarget(self,
                         action: #selector(didTappedNewGame),
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

    private lazy var secondaryButtonsStack = makeStackView(axis: .horizontal,
                                                           spacing: 250,
                                                           views: [settingsButton,
                                                                   helpButton])

    private lazy var mainButtonsStack = makeStackView(axis: .vertical,
                                                      spacing: stackSpacing,
                                                      views: [newGameButton,
                                                              statisticButton])

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundBlue
        setupRainbow()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods
    
    private func makeStackView(axis: NSLayoutConstraint.Axis, 
                               spacing: CGFloat,
                               views: [UIView] = []) -> UIStackView {
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
    }
    
    // MARK: - Selector Methods
    
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
}

    // MARK: - Extensions

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
