import Foundation
import UIKit
import SnapKit

enum RainbowColors: String, CaseIterable {
    case red = "красный"
    case pink = "розовый"
    case orange = "оранжевый"
    case yellow = "желтый"
    case green = "зеленый"
    case lightBlue = "голубой"
    case blue = "синий"
    case purple = "фиолетовый"
    case white = "белый"
    
    var color: UIColor {
        switch self{
        case .red:
            return .red
        case .pink:
            return UIColor(red: 0.99, green: 0.13, blue: 0.64, alpha: 1.00)
        case .orange:
            return Palette.orange
        case .yellow:
            return Palette.yellow
        case .green:
            return Palette.green
        case .lightBlue:
            return UIColor(red: 0.26, green: 0.67, blue: 1.00, alpha: 1.00)
        case .blue:
            return UIColor(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)
        case .purple:
            return Palette.purple
        case .white:
            return .white
        }
    }
}

class GameView: UIView {
    // MARK: Properties
    
    var colorViews = [ColorsPatternView]()
    
    var colorsAnimator: UIViewPropertyAnimator?
    
    let countColors = 100.0
    
    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
        
        randomColorViews(count: Int(countColors))
        addPatterns()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomColor() -> RainbowColors {
        return RainbowColors.allCases.randomElement() ?? .red
    }
    
    func randomColorViews(count: Int) {
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
            colorView.frame = CGRect(
                x: Double.random(in: 20...280),
                y: UIScreen.main.bounds.height - sizeBetweenColors,
                width: 100,
                height: 100
            )
            
            sizeBetweenColors -= 250
        }
        
        colorsAnimator = UIViewPropertyAnimator(duration: countColors * 2.5, curve: .linear) {
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
}

