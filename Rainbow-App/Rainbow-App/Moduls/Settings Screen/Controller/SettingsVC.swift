import UIKit
import SnapKit

struct Settings {
    var title: String
    var type: SettingsViewCell.SettingsCellType
    var value: Int
}

class SettingsVC: UIViewController {

    let settingsView = SettingsView()
    
    var game: Game?

    var settings: [Settings] = [
        Settings(title: "Время игры, мин", type: .gameTime, value: 0),
        Settings(title: "Скорость смены заданий, сек", type: .gameSpeed, value: 0),
        Settings(title: "Цвета слов", type: .wordsColor, value: 0),
        Settings(title: "Размер букв", type: .fontSize, value: 0),
        Settings(title: "Подложка для букв", type: .letterBackground, value: 0),
        Settings(title: "Игра с проверкой", type: .checkGame, value: 0),
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        let int = UserDefaultsManager.instance.fetchSlider()
        let int = UserDefaults.standard.integer(forKey: "forDurationSliderKey")
        let double = UserDefaults.standard.double(forKey: "forStepperKey")
        let bool = UserDefaults.standard.bool(forKey: "forToggleKey")
        let speed = UserDefaults.standard.string(forKey: "forSpeedKey")
        print(int)
        print(double)
        print(bool)
        print(speed)
      /* Сохранение настроек, таких как: скорость смены заданий, подложка, размер букв и время игры работает.
         Принты выше ни на что не влияют и созданы только для проверки работы сохраения в UserDefaults.
         Сам файл с UserDefaultsManager, по сути, и не нужен. Есть идея, как зарефакторить, но уже утром (там быстро будет).
         Сохранение идёт автоматом в методах @objc SettingsViewCell и в методе этого класса (SettingsVC). 
         */
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsViewCell.identifier, for: indexPath) as! SettingsViewCell
        let setting = settings[indexPath.row]
        cell.slider.tag = indexPath.row
        cell.slider.addTarget(self, action: #selector(durationSliderChanged), for: .valueChanged)
        cell.configure(with: setting.title, type: setting.type)
        cell.countLabel.text = "\(setting.value)" // Устанавливаем текущее значение слайдера
        print("Cell created at index: \(indexPath.row)")

        return cell
    }


    @objc func durationSliderChanged(_ sender: UISlider) {
        let index = sender.tag
        let newValue = Int(sender.value)

        print("Slider changed at index: \(index), new value: \(newValue)")

        // Обновляем данные в массиве settings
        settings[index].value = newValue
        UserDefaults.standard.set(newValue, forKey: "forDurationSliderKey")
        // Обновляем ячейку
        if let cell = settingsView.settingsTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SettingsViewCell {
          
            cell.countLabel.text = "\(newValue)"
        }
    }
}
