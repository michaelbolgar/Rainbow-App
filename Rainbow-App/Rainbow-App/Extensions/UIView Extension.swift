import UIKit

extension UIView {
    
    func addAllTheSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addDashedBorder() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineDashPattern = [4,4]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    func createBackground() {
        
    }
}
