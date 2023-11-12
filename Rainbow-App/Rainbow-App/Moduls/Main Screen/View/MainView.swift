import Foundation
import UIKit
import SnapKit

class MainView: UIView {

    // MARK: UI Elements

    let helloLabel = UILabel.makeLabel(text: "Hello, world!", font: UIFont.systemFont(ofSize: 40), textColor: UIColor.black)

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.orange
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func setupLayout() {

        self.addSubview(helloLabel)

        helloLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(300)
            make.centerX.equalToSuperview()
        }
    }

}
