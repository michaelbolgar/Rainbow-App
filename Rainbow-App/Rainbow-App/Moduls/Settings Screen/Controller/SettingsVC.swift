import UIKit
import SnapKit

class SettingsVC: UIViewController {

    private var udManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    private var cells = CellModel.makeCells()

    //MARK: UI Elements

    let settingsView = SettingsView()

    //MARK: Controller's life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setNavigationBar(title: "Настройки")
        setupView()
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
    }

    // MARK: Private Methods

    private func setupView() {
        view.addSubview(settingsView)
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        updateBackgroundColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: Notification.Name("ThemeChanged"), object: nil)
    }

    //MARK: Selector Methods

    @objc
    private func updateBackgroundColor() {
        settingsView.backgroundColor = ThemeManager.shared.currentBackground
    }
}

    //MARK: SettingsVC Extension

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewCell.identifier, for: indexPath) as! SettingsViewCell
        let setting = cells[indexPath.row]
        cell.configure(with: setting.title, type: setting.type)
        return cell
    }
}
