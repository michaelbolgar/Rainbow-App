import UIKit
import SnapKit

class ColorGridView: UIView {

    // MARK: Properties

    private var colorSquares: [UIView] = []
    private var colors: [UIColor] = [Palette.orange, Palette.yellow, Palette.green, Palette.purple, Palette.pink, Palette.lightBlue, UIColor.red, UIColor.white, Palette.blue2, UIColor.systemCyan]
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

        if selectedSquareIndex != nil {
            let square = colorSquares[index]
            if let checkMarkLayer = square.subviews.first as? UIImageView {
                checkMarkLayer.isHidden.toggle()

            }
        }

    }

    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }

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
