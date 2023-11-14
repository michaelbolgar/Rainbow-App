import UIKit
import SnapKit

class StatisticsVC: UIViewController {
    
    let games = ["4", "3", "2", "1"]
    
    //MARK: - UI Componets
    
    let statisticsView = StatisticsView()
    
    //MARK: Controller's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.backgroundBlue
        statisticsView.resultsTableView.delegate = self
        statisticsView.resultsTableView.dataSource = self
        setupView()
    }
    
    // MARK: Methods
    
    private func setupView() {
        
        view.addSubview(statisticsView)
        
        statisticsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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


