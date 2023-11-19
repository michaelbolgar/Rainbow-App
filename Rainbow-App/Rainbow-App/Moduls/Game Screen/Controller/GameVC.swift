import UIKit
import Speech
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
    let userDefaultsTime = UserDefaults.standard.integer(forKey: "forDurationSliderKey") * 60
    lazy var timeLeft = userDefaultsTime
    
    lazy var restartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать заново", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.tintColor = .white
        button.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        return button
    }()
    
    @objc func restartGame() { //упростить - много повторяющегося кода
        timeLeft = userDefaultsTime
        setupView()
        timerStart()
        restartButton.isHidden = true
        gameView.startGame()
        title = formattedTimer()
        if gameView.isCheckedVer {
            gameView.startRecognition()
        }
    }

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(title: formattedTimer())
        
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        start() //вынести вызов ?
        if gameView.isCheckedVer {
            gameView.startRecognition()
        }
        
        setupView()
        timerStart()
    }

    // MARK: Methods

    private func setupView() {

        view.addSubview(gameView)
        gameView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(restartButton)
        restartButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        restartButton.isHidden = true

        updateBackgroundColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: Notification.Name("ThemeChanged"), object: nil)
    }
    
    private func timerStart() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
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
            gameView.colorViews.forEach {
                $0.removeFromSuperview()
            }
            gameView.colorViews.removeAll()
            if gameView.isCheckedVer {
                gameView.stop()
            }
            navigationItem.rightBarButtonItem?.isEnabled = true //? надо ли
            restartButton.isHidden = false
            let statisticVC = StatisticsVC()
            present(statisticVC, animated: true)
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
    
    func start() {
        SFSpeechRecognizer.requestAuthorization { status in
            OperationQueue.main.addOperation {
                switch status {
                case .notDetermined:
                    print("Speech recognition not yet authorized")
                case .denied:
                    print("User denied access to speech recognition")
                case .restricted:
                    print("Speech recognition restricted on this device")
                case .authorized:
                    if self.gameView.isCheckedVer {
                        self.gameView.answerLine.isHidden = false
                    }
//                    self.startRecognition()
                @unknown default:
                    print("default")
                }
            }
        }
    }

    //MARK: Selector Metods

    @objc
    private func updateBackgroundColor() {
        gameView.backgroundColor = ThemeManager.shared.currentBackground
    }

    @objc func didTapPause() {
        isPaused.toggle()

        if isPaused {
            self.gameView.colorsAnimator?.pauseAnimation()
            self.timer?.invalidate()
            gameView.speedButton.isHidden = true
            if gameView.isCheckedVer {
                gameView.stop()
            }
        } else {
            gameView.colorsAnimator?.startAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)

            gameView.speedButton.isHidden = false
            if gameView.isCheckedVer {
                gameView.startRecognition()
            }
        }
    }
}

