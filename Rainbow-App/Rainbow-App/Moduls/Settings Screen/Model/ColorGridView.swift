import UIKit
import SnapKit

class ColorGridView: UIView {

    // MARK: Properties

    private let udManager: UserDefaultsManagerProtocol = UserDefaultsManager()

    var colorSquares: [UIView] = []

    //цвета UIColor.gray нет в палитре игры, добавлен сюда чтобы было чётное количество квадратиков в настройках. Добавить цвет в игровую палитру
    private var colors: [UIColor] = [UIColor.orange, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.pink, UIColor.blue, UIColor.red, UIColor.white, UIColor.lightBlue, UIColor.gray]

    private var selectedSquareIndex: Int? = nil

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCheckmark()
        setupTapGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func setupUI() {

        self.snp.makeConstraints { make in
            make.width.equalTo(150)
        }

        let colorSquareSize: CGFloat = 20
        for row in 0..<2 {
            for col in 0..<5 {
                let square = UIView()
                square.layer.borderWidth = 1
                square.layer.borderColor = UIColor.black.cgColor
                addSubview(square)

                square.snp.makeConstraints { make in
                    make.width.height.equalTo(colorSquareSize)
                    make.top.equalToSuperview().offset(CGFloat(row) * (colorSquareSize + 5))
                    make.leading.equalToSuperview().offset(CGFloat(col) * (colorSquareSize + 5))
                }

                colorSquares.append(square)
            }
        }

        for (i, square) in colorSquares.enumerated() {
            square.backgroundColor = colors[i]
        }
    }

    private func setupCheckmark() {
        for (_, square) in colorSquares.enumerated() {

            let checkMark = UIImageView(image: UIImage(systemName: "checkmark"))
            checkMark.tintColor = .black
            square.addSubview(checkMark)

            checkMark.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }

            checkMark.isHidden = true

        }
    }

    private func selectColorSquare(at index: Int) {

        selectedSquareIndex = index

        if let selectedSquareIndex = selectedSquareIndex {
            if selectedSquareIndex == index {
                let square = colorSquares[index]
                if let checkMarkLayer = square.subviews.first as? UIImageView {
                    checkMarkLayer.isHidden.toggle()
                }

                // Save selected color indices in UserDefaults
                let selectedIndices = colorSquares
                    .enumerated()
                    .filter { $0.element.subviews.first as? UIImageView != nil && !($0.element.subviews.first as! UIImageView).isHidden }
                    .map { $0.offset }

                udManager.set(selectedIndices, forKey: .selectedColors)
                print(udManager.getArray(forKey: .selectedColors))
            } else {
                // Another color square is selected, update selectedSquareIndex
                self.selectedSquareIndex = index
            }
        } else {
                // No color square is selected, set selectedSquareIndex and toggle check mark visibility
                self.selectedSquareIndex = index
                let square = colorSquares[index]
                if let checkMarkLayer = square.subviews.first as? UIImageView {
                    checkMarkLayer.isHidden.toggle()
                }

                // Save selected color indices in UserDefaults
                let selectedIndices = colorSquares
                    .enumerated()
                    .filter { $0.element.subviews.first as? UIImageView != nil && !($0.element.subviews.first as! UIImageView).isHidden }
                    .map { $0.offset }

                udManager.set(selectedIndices, forKey: .selectedColors)
                print(udManager.getArray(forKey: .selectedColors))
        }
    }

    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

    //MARK: Selector Methods

    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        for (index, square) in colorSquares.enumerated() {
            if square.frame.contains(location) {
                selectColorSquare(at: index)
                break
            }
        }
    }
}
