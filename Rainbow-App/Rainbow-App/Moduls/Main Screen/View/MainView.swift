import Foundation
import UIKit
import SnapKit

class MainView: UIView {

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.orange
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
