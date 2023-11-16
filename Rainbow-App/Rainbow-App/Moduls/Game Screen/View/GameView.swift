import Foundation
import UIKit
import SnapKit

enum Speed: String {
    case x1 = "x1"
    case x2 = "x2"
    case x3 = "x3"
    case x4 = "x4"
    case x5 = "x5"
}

class GameView: UIView {
    // MARK: Properties
    
    var colorViews = [ColorsPatternView]()

    var colorsAnimator: UIViewPropertyAnimator?

    var countColors = 100.0
    lazy var speed = countColors * 4
    var defaultSpeed = Speed.x1.rawValue
    var isBackground: Bool = true
    
    lazy var speedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(defaultSpeed, for: .normal)
        button.tintColor = .white
        button.layer.backgroundColor = UIColor.red.cgColor
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = false
        
        button.addTarget(self, action: #selector(speedButtonTapped), for: .touchUpInside)
        
        return button
    }()

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
        setupView()
        randomColorViews(count: Int(countColors))
        addPatterns()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(speedButton)
        speedButton.snp.makeConstraints { make in
            make.bottomMargin.trailingMargin.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
        }
    }
    
    //MARK: - CREATE Color Views
    
    private func randomColor() -> RainbowColors {
        return RainbowColors.allCases.randomElement() ?? .red
    }
    
    private func randomColorViews(count: Int) {
        for _ in 0..<count {
            let randomTitle = randomColor().rawValue
            let randomColor = randomColor().color
            colorViews.append(ColorsPatternView(title: randomTitle, color: randomColor, background: isBackground))
        }
    }
    
    private func addPatterns() {
        var sizeBetweenColors = 0.0
        
        for colorView in colorViews {
            addSubview(colorView)
            bringSubviewToFront(speedButton)
            colorView.frame = CGRect(
                x: Double.random(in: isBackground ? 20...280 : 10...260),
                y: UIScreen.main.bounds.height - sizeBetweenColors,
                width: 100,
                height: 100
            )
            
            sizeBetweenColors -= 250
        }
        
        colorsAnimator = UIViewPropertyAnimator(duration: speed, curve: .linear) {
            self.colorViews.forEach { color in
                color.frame = CGRect(
                    x: color.frame.origin.x,
                    y: self.frame.height + sizeBetweenColors,
                    width: 100,
                    height: 100
                )
                color.alpha = 0
            }
        }
        
        colorsAnimator?.startAnimation()
    }
    
    //MARK: - Speed button
    
    @objc func speedButtonTapped() {
        switch defaultSpeed {
        case Speed.x1.rawValue:
            settingSpeed(Speed.x2, 1/2)
        case Speed.x2.rawValue:
            settingSpeed(Speed.x3, 1/3)
        case Speed.x3.rawValue:
            settingSpeed(Speed.x4, 1/4)
        case Speed.x4.rawValue:
            settingSpeed(Speed.x5, 1/5)
        default:
            settingSpeed(Speed.x1, 1/1)
        }
    }
    
    func settingSpeed(_ xSpeed: Speed, _ duration: CGFloat) {
        defaultSpeed = xSpeed.rawValue
        speedButton.setTitle(xSpeed.rawValue, for: .normal)
        colorsAnimator?.pauseAnimation()
        colorsAnimator?.continueAnimation(withTimingParameters: .none, durationFactor: duration)
    }
}

