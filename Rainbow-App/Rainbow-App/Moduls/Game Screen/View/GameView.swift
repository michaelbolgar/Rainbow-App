import Foundation
import UIKit
import SnapKit
import Speech

enum Speed: String {
    case x1 = "x1"
    case x2 = "x2"
    case x3 = "x3"
    case x4 = "x4"
    case x5 = "x5"
}

class GameView: UIView {
    
    // MARK: Extension Properties
    
    private(set) var recognizedText = ""
    
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    // MARK: Properties
    var colorViews = [ColorsPatternView]()

    var colorsAnimator: UIViewPropertyAnimator?

    var countColors = 100.0
    lazy var speed = countColors * 4
    var defaultSpeed = Speed.x1.rawValue
    var isBackground: Bool = true
    
    let answerLine = UIView()
    let answerLineCoordinate = (xStart: 0, xEnd: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height / 2 - 200)
    
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
        createDisplayLink()
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
        
        addSubview(answerLine)
        answerLine.frame = CGRect(
            x: CGFloat(answerLineCoordinate.xStart),
            y: answerLineCoordinate.y,
            width: answerLineCoordinate.xEnd,
            height: 0)
        answerLine.addDashedBorder()
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
                
//                print(color.title, color.frame)
            }
            
        }
        
        colorsAnimator?.startAnimation()
//        for colorView in colorViews {
//            print(colorView.title, colorView.layer.presentation()?.frame ?? "хз")
//        }
//        checkСontactWithAnswerLine()
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
    
    //MARK: - Check Answer
    
    private func createDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(firstCheck))
        displayLink.add(to: .current, forMode: .default)
    }
    
    @objc func firstCheck(displayLink: CADisplayLink) {
        colorViews.forEach { colorView in
            checkСontactWithAnswerLine(colorView)
        }
    }
    
    func checkСontactWithAnswerLine(_ colorView: ColorsPatternView) {
        if let colorViewPresentationFrame = colorView.layer.presentation()?.frame,
            let answerLinePresentationFrame = answerLine.layer.presentation()?.frame {
            let colorViewY = colorViewPresentationFrame.origin.y
            let lineAnswerY = answerLinePresentationFrame.origin.y
            
//            let colorViewX = colorViewPresentationFrame.origin.x
            
//            let colorViewYBottom = colorViewPresentationFrame.origin.y + colorViewPresentationFrame.height //colorViewY + colorViewPresentationFrame.height ???
            
            if colorViewY - lineAnswerY < .zero
                && colorViewY  - lineAnswerY > -colorViewPresentationFrame.height {
                print(colorView.color.accessibilityName, "-", recognizedText)
                if recognizedText == colorView.color.accessibilityName {
                    print("HALLILUYA")
                }
//                print(colorView.title)
            }
        }
    }
    
    func checkVoice() {
//        VoiceChecker.shared.startRecognition()
//        if VoiceChecker.shared.recognizedText ==
    }
}

extension GameView {
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
                    self.startRecognition()
                @unknown default:
                    print("default")
                }
            }
        }
    }
    
    func startRecognition() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let inputNode = audioEngine.inputNode
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                self.recognitionRequest?.append(buffer)
            }
            
            
            audioEngine.prepare()
            try audioEngine.start()
            
            
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
            recognitionRequest.shouldReportPartialResults = true
            recognitionRequest.requiresOnDeviceRecognition = true
            
            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false
                
                if let result = result {
                    self.recognizedText = result.bestTranscription.formattedString
                    isFinal = result.isFinal
                }
                
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                }
            }
            self.recognizedText = "Слушаю..."
            
//            print(recognizedText)
        }
        catch {
            print("HEEEEEEEEELP")
        }
    }
    
    func stop() {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
}

