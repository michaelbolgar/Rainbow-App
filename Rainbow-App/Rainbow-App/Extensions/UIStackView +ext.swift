import UIKit

extension UIStackView {
    
    func addAllArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
