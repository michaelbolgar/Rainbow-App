import UIKit
import SnapKit

class GameVC: UIViewController {
    
    var didTapedPauseButton: (() -> Void)? //

    let gameView = GameView()
    
    var isPaused: Bool = false {
            didSet {
                let image = UIImage(systemName: isPaused ? "play.circle" : "pause.circle")
                addBarButtonItem.image = image
                addBarButtonItem.tintColor = .white
            }
        }

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setNavigationBackButton(title: "")
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(gameView)

        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        didTapedPauseButton?()
        
        if isPaused {
            self.gameView.colorsAnimator?.pauseAnimation()
            self.gameView.timer?.invalidate()
        } else {
            gameView.colorsAnimator?.startAnimation()
//            gameView.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        }
    }
}

