import Foundation
import UIKit
import SnapKit

class SettingsView: UIView {
    
    lazy var settingsTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.isScrollEnabled = true
        tableView.register(SettingsViewCell.self, forCellReuseIdentifier: SettingsViewCell.identifier)
        return tableView
    }()
    
    // MARK: Init
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.purple
        
        self.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

