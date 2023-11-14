import UIKit

extension UIView {
    
    func addAllTheSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
