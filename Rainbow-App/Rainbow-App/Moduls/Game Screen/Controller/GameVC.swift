import UIKit
import SnapKit

class GameVC: UIViewController {

    let gameView = GameView()
    
    var isPaused: Bool = false {
            didSet {
                let image = UIImage(systemName: isPaused ? "play.circle" : "pause.circle")
                addBarButtonItem.image = image
                addBarButtonItem.tintColor = .white
            }
        }
    
    var timer: Timer?
    var timeLeft = 75

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationBar(title: formattedTimer())
        
        navigationItem.rightBarButtonItem = addBarButtonItem
        gameView.start()
    }

    // MARK: Methods

    private func setupView() {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        view.addSubview(gameView)
        
        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func formattedTimer() -> String {
        switch timeLeft {
        case 0...9:
            return "00:0\(timeLeft)"
        case 10..<60:
            return "00:\(timeLeft)"
        default:
            let beforeThePoint = timeLeft / 60
            let afterThePoint = timeLeft % 60
            if afterThePoint < 10 {
                return "\(beforeThePoint):0\(afterThePoint)"
            }
            return "\(beforeThePoint):\(afterThePoint)"
        }
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        title = formattedTimer()
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            
            gameView.colorsAnimator?.stopAnimation(true)
            gameView.colorsAnimator?.finishAnimation(at: .end)
            gameView.colorViews.forEach { $0.removeFromSuperview() }
            gameView.colorViews.removeAll()
            
            navigationItem.rightBarButtonItem = nil //? надо ли
        }
    }
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        let button =  UIBarButtonItem(
            image: UIImage(systemName: "pause.circle"),
            style: .plain,
            target: self,
            action: #selector(didTapPause))
        button.tintColor = .white
        return button
    }()
    
    @objc func didTapPause() {
        isPaused.toggle()
        
        if isPaused {
            self.gameView.colorsAnimator?.pauseAnimation()
            self.timer?.invalidate()
            gameView.stop()
            gameView.speedButton.isHidden = true
        } else {
            gameView.colorsAnimator?.startAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            gameView.start()
            gameView.speedButton.isHidden = false
        }
    }
}

