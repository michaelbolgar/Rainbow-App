import UIKit
import SnapKit

struct Settings {
    var title: String
    var type: SettingsViewCell.SettingsCellType
    var value: Int
}

class SettingsVC: UIViewController {

    //MARK: Properties
    let settingsView = SettingsView()
    
    private let udManager: UserDefaultsManagerProtocol = UserDefaultsManager()

    var settings: [Settings] = [
        Settings(title: "Время игры, мин", type: .gameTime, value: 0),
        Settings(title: "Скорость смены заданий, сек", type: .gameSpeed, value: 0),
        Settings(title: "Цвета слов", type: .wordsColor, value: 0),
        Settings(title: "Размер букв", type: .fontSize, value: 0),
        Settings(title: "Подложка для букв", type: .letterOrBackground, value: 0),
        Settings(title: "Проверка голосом", type: .checkGame, value: 0),
        Settings(title: "Цвет фона", type: .backgroundGameColor, value: 0)
    ]

    //MARK: Controller's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        setNavigationBar(title: "Настройки")
        setupView()
        settingsView.settingsTableView.delegate = self
        settingsView.settingsTableView.dataSource = self
    }

    // MARK: Methods
    private func setupView() {
        view.addSubview(settingsView)
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        updateBackgroundColor()
        NotificationCenter.default.addObserver(self, selector: #selector(updateBackgroundColor), name: Notification.Name("ThemeChanged"), object: nil)
    }

    //MARK: Selector Metods
    @objc
    private func updateBackgroundColor() {
        settingsView.backgroundColor = ThemeManager.shared.currentBackground
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewCell.identifier, for: indexPath) as! SettingsViewCell
        let setting = settings[indexPath.row]
        cell.configure(with: setting.title, type: setting.type)
        return cell
    }
}
