//
//  StatisticsViewCell.swift
//  Rainbow-App
//
//  Created by Caroline Tikhomirova on 13.11.2023.
//

import UIKit

class StatisticsViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "StatisticsViewCell"
    
    //MARK: - UI Componets
    private let cellBackView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var numberOfGameLabel = UILabel.makeLabel(font: UIFont.alice(size: 20), textColor: UIColor.raspberry)
    
    private var timeOfGameLabel = UILabel.makeLabel(font: UIFont.alice(size: 20), textColor: .black)
    
    private var speedOfGameLabel = UILabel.makeLabel(font: UIFont.alice(size: 20), textColor: .black)
    
    private var scopeLabel = UILabel.makeLabel(font: UIFont.alice(size: 20), textColor: UIColor.green)
    //MARK: - Unit
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = .clear
        
        [cellBackView, numberOfGameLabel, timeOfGameLabel, speedOfGameLabel, scopeLabel].forEach{self.addSubview($0)}
        
        cellBackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }
        numberOfGameLabel.snp.makeConstraints { $0.top.left.greaterThanOrEqualTo(cellBackView).inset(10) }
        timeOfGameLabel.snp.makeConstraints { $0.bottom.left.greaterThanOrEqualTo(cellBackView).inset(10) }
        speedOfGameLabel.snp.makeConstraints { $0.top.right.greaterThanOrEqualTo(cellBackView).inset(10) }
        scopeLabel.snp.makeConstraints { $0.bottom.right.greaterThanOrEqualTo(cellBackView).inset(10) }
    }
    
    func configure(with result: GameResult) {
        numberOfGameLabel.text = "игра № \(result.orderNumber)"
        timeOfGameLabel.text = "время \(result.time)"
        speedOfGameLabel.text = "скорость х\(result.speed)"
        scopeLabel.text = "угадано \(result.score)/\(result.totalWords)"
    }
}
