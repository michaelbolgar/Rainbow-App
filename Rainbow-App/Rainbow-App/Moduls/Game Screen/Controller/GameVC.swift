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
    var timeLeft = 59

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationBar(title: "00:\(timeLeft)")
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }

    // MARK: Methods

    private func setupView() {
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        
        view.addSubview(gameView)
        
        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func onTimerFires() {
        timeLeft -= 1
        title = "00:\(timeLeft)"
        
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
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
        } else {
            gameView.colorsAnimator?.startAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        }
    }
}

