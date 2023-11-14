import Foundation
import UIKit
import SnapKit

protocol StatisticsViewDelegate: AnyObject {
    func cleanButtonTapped()
}

class StatisticsView: UIView {
    
    weak var delegate: StatisticsViewDelegate?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .alice(size: 20)
        label.textColor = .black
        return label
    }()
    
    var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Palette.backgroundBlue
        tableView.separatorStyle = .none
        tableView.rowHeight = 96
        tableView.isScrollEnabled = true
        tableView.register(StatisticsViewCell.self, forCellReuseIdentifier: StatisticsViewCell.identifier)
        return tableView
    }()
    
    private let cleanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить статистику", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.caveat(size: 20)
        button.backgroundColor = Palette.blue
        button.layer.shadowColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    // MARK: Init
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
        
        [resultsTableView, cleanButton].forEach{self.addSubview($0)}
        
        resultsTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(121)
            
        }
        
        cleanButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(55)
            $0.horizontalEdges.equalToSuperview().inset(55)
            $0.height.equalTo(63)
        }
        
        cleanButton.addTarget(self, action: #selector(didTappedCleanButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTappedCleanButton() {
        delegate?.cleanButtonTapped()
    }
}


