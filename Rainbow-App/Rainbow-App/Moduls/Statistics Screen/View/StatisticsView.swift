import Foundation
import UIKit
import SnapKit

class StatisticsView: UIView {
    
    private lazy var tableView: UITableView = {
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(StatisticsViewCell.self, forCellReuseIdentifier: StatisticsViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.backgroundBlue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

