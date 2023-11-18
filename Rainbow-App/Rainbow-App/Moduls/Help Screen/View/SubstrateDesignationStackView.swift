import UIKit
import SnapKit

final class SubstrateDesignationStackView: UIStackView {
    
    enum Constants {
        static let firstTypeOfGameText = "без подложки"
        static let secondTypeOfGameText = "с включённой подложкой"
        static let typeOfSubstrate = "белый"
        
        static let spacingForStackView: CGFloat = 15
    }

    private lazy var circleView = ColorsPatternView(title: "белый", color: Palette.blue, background: true)
    
    private lazy var leftStack: UIStackView = {
        let firstStackView = UIStackView()
        firstStackView.axis = .vertical
        firstStackView.spacing = Constants.spacingForStackView
        firstStackView.distribution = .equalSpacing
        return firstStackView
    }()
    
    private lazy var rightStack: UIStackView = {
        let secondStackView = UIStackView()
        secondStackView.axis = .vertical
        secondStackView.distribution = .fillProportionally
        
        secondStackView.spacing = Constants.spacingForStackView
        return secondStackView
    }()
    
    private lazy var firstTypeLabel: UILabel = {
        let firstTypeLabel = UILabel()
        firstTypeLabel.text = Constants.firstTypeOfGameText
        firstTypeLabel.font = .alice(size: 10) ?? .systemFont(ofSize: 10)
        firstTypeLabel.backgroundColor = .clear
        return firstTypeLabel
    }()
    
    private lazy var firstSubstrateTypeLabel: UILabel = {
        let firstSubstrateTypeLabel = UILabel()
        firstSubstrateTypeLabel.textColor = Palette.blue
        firstSubstrateTypeLabel.text = Constants.typeOfSubstrate
        firstSubstrateTypeLabel.font = .systemFont(ofSize: 20)
        return firstSubstrateTypeLabel
    }()
    
    private lazy var secondTypeLabel: UILabel = {
        let secondTypeLabel = UILabel()
        secondTypeLabel.text = Constants.secondTypeOfGameText
        secondTypeLabel.font = .alice(size: 10) ?? .systemFont(ofSize: 10)
        secondTypeLabel.backgroundColor = .clear
        return secondTypeLabel
    }()
    
    private lazy var secondSubstrateTypeLabel: UILabel = {
        let secondSubstrateTypeLabel = UILabel()
        secondSubstrateTypeLabel.textColor = Palette.blue
        secondSubstrateTypeLabel.text = Constants.typeOfSubstrate
        secondSubstrateTypeLabel.font = .systemFont(ofSize: 20)
        return secondSubstrateTypeLabel
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        drawSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SubstrateDesignationStackView {
    
    func drawSelf() {
        backgroundColor = .clear
        axis = .horizontal
        distribution = .equalSpacing
        spacing = 50
        addAllArrangedSubviews(leftStack,
                               rightStack)
        leftStack.addAllArrangedSubviews(firstTypeLabel,
                                         firstSubstrateTypeLabel)
        rightStack.addAllArrangedSubviews(secondTypeLabel,
                                          secondSubstrateTypeLabel)
    }
}
