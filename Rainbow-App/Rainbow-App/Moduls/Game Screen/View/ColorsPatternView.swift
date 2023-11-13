//
//  ColorsPatternView.swift
//  Rainbow-App
//
//  Created by Лилия Феодотова on 13.11.2023.
//

import UIKit
import SnapKit

class ColorsPatternView: UIView {
    
    let title: String
    let color: UIColor
    var background: Bool = true {
        didSet {
            
        }
    }
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let labelView = UILabel()
    
    func setupLabel() {
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.text = title
        labelView.textAlignment = .center
        labelView.font = .systemFont(ofSize: 14, weight: .bold)
        labelView.textColor = background ? .black : color
        labelView.backgroundColor = background ? color : .clear
        labelView.layer.cornerRadius = background ? 50 : 0
        labelView.layer.borderWidth = 1.5
        labelView.layer.borderColor = UIColor.white.cgColor
        labelView.layer.masksToBounds = true
        
        addSubview(labelView)
        
        labelView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(self)
        }
    }
}
