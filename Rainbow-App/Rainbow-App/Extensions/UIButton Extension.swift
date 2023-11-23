import UIKit

extension UIButton {
    static func makeButton(text: String = "") -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.alice(size: 20)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 3.0
        button.layer.shadowOpacity = 0.5
        button.snp.makeConstraints { make in
            make.width.equalTo(274)
            make.height.equalTo(52)
        }
        return button
    }
}
