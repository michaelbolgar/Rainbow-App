import Foundation
import UIKit
import SnapKit

protocol StatisticsViewDelegate: AnyObject {
    func cleanButtonTapped()
}

class StatisticsView: UIView {
    
    //MARK: - Constants
    
    enum Constants {
        
        static let textCleanButton = "Очистить статистику"
        static let textEmptyStatistics =
                                            """
                                            Упсс...
                                            статистики нет
                                            Let's play!
                                            """
    }
    
    //MARK: - Properties
    
    weak var delegate: StatisticsViewDelegate?
    
    //MARK: - UI Components
    
    var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Palette.backgroundBlue
        tableView.separatorStyle = .none
        tableView.rowHeight = 96
        tableView.isScrollEnabled = true
        tableView.register(StatisticsViewCell.self, forCellReuseIdentifier: StatisticsViewCell.identifier)
        return tableView
    }()
    
    let emptyStatisticsLabel = UILabel.makeMultiLineLabel(text: Constants.textEmptyStatistics, font: UIFont.alice(size: 26), textColor: .white, numberOfLines: 3)
    
    let cleanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.textCleanButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.alice(size: 20)
        button.backgroundColor = Palette.blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Init
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
        emptyStatisticsLabel.isHidden = true
        
        [resultsTableView, emptyStatisticsLabel, cleanButton].forEach{self.addSubview($0)}
        
        resultsTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(121)
        }
        
        emptyStatisticsLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
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
    
    //MARK: - Methods
    
    @objc private func didTappedCleanButton() {
        delegate?.cleanButtonTapped()
    }
}


