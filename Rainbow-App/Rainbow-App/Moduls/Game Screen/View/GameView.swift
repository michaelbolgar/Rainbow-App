import Foundation
import UIKit
import SnapKit

class GameView: UIView {
    // MARK: Properties
    
    var colorViews = [ColorsPatternView]()
    
    var colorsAnimator: UIViewPropertyAnimator?
    
    var timer: Timer?
    var timeLeft = 59
    
    var isPaused: Bool = false
    
    let countColors = 100.0
    lazy var speed = countColors * 2.5
    
    let timerLabel = UILabel.makeLabel(font: .alice(size: 30), textColor: .white)
    
    lazy var speedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X2", for: .normal)
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
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        timerLabel.text = "00:\(timeLeft)"
        
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(65) //?
        }
        
        addSubview(speedButton)
        speedButton.snp.makeConstraints { make in
            make.bottomMargin.trailingMargin.equalToSuperview().offset(-20)
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
            bringSubviewToFront(timerLabel)
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
    
    //MARK: - TIMER
    
    @objc func onTimerFires() {
        timeLeft -= 1
        timerLabel.text = "00:\(timeLeft)"
     
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
        }
    }
    
    //MARK: - Speed button
    
    @objc func speedButtonTapped() {
        speed = speed / 2
        colorsAnimator = UIViewPropertyAnimator(duration: speed, curve: .linear)
        colorsAnimator?.startAnimation(afterDelay: speed)
    }
}

