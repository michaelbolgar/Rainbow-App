import UIKit

extension UILabel {

    static func makeLabel(text: String = "", font: UIFont?, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeMultiLineLabel(text: String = "", font: UIFont?, textColor: UIColor, numberOfLines: Int) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = .center
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeLabelHelpView(text: String = "", font: UIFont?, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
