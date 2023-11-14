import UIKit
import SnapKit

class StatisticsVC: UIViewController {
    
    let games = ["4", "3", "2", "1"]
    
    //MARK: - UI Componets
    
    //let statisticsView = StatisticsView()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .alice(size: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var resultsTableView: UITableView = {
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
    
    
    
    //MARK: Controller's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.backgroundBlue
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        setupView()
    }
    
    // MARK: Methods
    
    private func setupView() {
        
        [resultsTableView, cleanButton].forEach{view.addSubview($0)}
        
        resultsTableView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(121)
            
        }
        
        cleanButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(55)
            $0.horizontalEdges.equalToSuperview().inset(55)
            $0.height.equalTo(63)
        }
    }
}

extension StatisticsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsViewCell.identifier, for: indexPath) as? StatisticsViewCell else {
            fatalError("Error")
        }
        let numberOfGame = games[indexPath.row]
        let timeInGame: Float = 10
        let speed: Float = 1
        let scope = 10
        let amountOfColors = 12
        cell.configure(game: numberOfGame, gameTime: timeInGame, speed: speed, scope: scope, amount: amountOfColors)
        return cell
    }
    
    
}


