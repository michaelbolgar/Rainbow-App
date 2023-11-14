import Foundation
import UIKit
import SnapKit

class MainView: UIView {

    // MARK: UI Elements

    let helloLabel = UILabel.makeLabel(text: "Привет, мир! ", font: UIFont.caveat(size: 40), textColor: UIColor.black)
    let circleView = UIView()
    let characterCircle = UILabel()
    let horizontalStack = UIStackView()
    
    let colors = [Palette.red, Palette.orange, Palette.yellow, Palette.green, Palette.blue, Palette.purple]
    let rainbowWord = ["р", "а", "д", "у", "г", "а"]

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.orange
        setupRainbow()
        setupLayout()
        characterCircle.snp.makeConstraints { make in
                    make.width.height.equalTo(40) // Ширина и высота для круга
                }
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods
    
    private func setupRainbow() {
        for i in 0...colors.count-1 {
            characterCircle.text = rainbowWord[i]
            characterCircle.textColor = .white
            characterCircle.backgroundColor = colors[i]
            characterCircle.layer.cornerRadius = 20
            characterCircle.textAlignment = .center
            characterCircle.clipsToBounds = true
            horizontalStack.addArrangedSubview(characterCircle)
        }
    }

    private func setupLayout() {

        self.addSubview(helloLabel)
        self.addSubview(horizontalStack)

        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(300)
            make.centerX.equalToSuperview()
        }
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(helloLabel.snp.bottom).offset(20)
//            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }

}
