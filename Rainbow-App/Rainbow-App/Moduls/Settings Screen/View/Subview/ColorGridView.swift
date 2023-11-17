//
//  ColorGridView.swift
//  Rainbow-App
//
//  Created by dsm 5e on 15.11.2023.
//

import UIKit
import SnapKit

class ColorGridView: UIView {
    
    private var colorSquares: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {

        self.snp.makeConstraints { make in
            make.width.equalTo(150)
        }

        let colorSquareSize: CGFloat = 18
        for row in 0..<2 {
            for col in 0..<6 {
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
    }
    
    func selectColorSquare(at index: Int) {
        for (i, square) in colorSquares.enumerated() {
            square.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            
            if i == index {
                let checkmarkLayer = CALayer()
                checkmarkLayer.contents = UIImage(named: "checkmark")?.cgImage
                checkmarkLayer.frame = square.bounds
                square.layer.addSublayer(checkmarkLayer)
            }
        }
    }
}
