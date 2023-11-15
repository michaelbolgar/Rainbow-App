import UIKit

extension UIButton {
    static func makeButton(text: String = "") -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.backgroundColor = Palette.blue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.alice(size: 20)
        button.snp.makeConstraints { make in
            make.width.equalTo(274)
            make.height.equalTo(52)
        }
        return button
    }
}
