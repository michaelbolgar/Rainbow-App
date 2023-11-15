import Foundation
import UIKit
import SnapKit

class GameView: UIView {
    // MARK: Properties
    
    var colorViews = [ColorsPatternView]()

    var colorsAnimator: UIViewPropertyAnimator?
    
    let speedTitle = ["x1", "x2", "x3", "x4", "x5"]
    var countColors = 100.0
    lazy var speed = countColors * 2.5
    
    lazy var speedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(speedTitle.first, for: .normal)
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
            colorViews.append(ColorsPatternView(title: randomTitle, color: randomColor))
        }
    }
    
    private func addPatterns() {
        var sizeBetweenColors = 0.0
        
        for colorView in colorViews {
            addSubview(colorView)
            bringSubviewToFront(speedButton)
            colorView.frame = CGRect(
                x: Double.random(in: 20...280),
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
        colorsAnimator?.pauseAnimation()
        colorsAnimator?.continueAnimation(withTimingParameters: .none, durationFactor: 1/3) //работает после паузы
        speedButton.setTitle(speedTitle[1], for: .normal)
        
    }
}

