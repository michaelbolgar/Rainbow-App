import UIKit
import SnapKit

class StatisticsVC: UIViewController {
    
    //MARK: - Constants
    
    enum Constants {
        
        static let titleText = "Статистика"
    }
    
    private var gameResults = Results()
    
    //MARK: - UI Componets
    
    let statisticsView = StatisticsView()
    
    //MARK: Controller's life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Palette.backgroundBlue
        statisticsView.delegate = self
        statisticsView.resultsTableView.delegate = self
        statisticsView.resultsTableView.dataSource = self
        setNavigationBar(title: Constants.titleText)
        setupView()
        
        gameResults.addResult(time: "3.43", speed: 1, score: 3, totalWords: 5)
        gameResults.addResult(time: "7.31", speed: 2, score: 11, totalWords: 12)
        gameResults.addResult(time: "12.3", speed: 1, score: 7, totalWords: 7)
        gameResults.addResult(time: "11.4", speed: 3, score: 14, totalWords: 16)
        
        updateUI()
    }
    
    // MARK: Methods
    
    private func setupView() {
        
        view.addSubview(statisticsView)
        
        statisticsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateUI() {
        
        if gameResults.results.count == 0 {
            statisticsView.resultsTableView.isHidden = true
            statisticsView.cleanButton.isHidden = true
            statisticsView.emptyStatisticsLabel.isHidden = false
        } else {
            statisticsView.reloadInputViews()
        }
    }
}


extension StatisticsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameResults.results.count
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StatisticsViewCell.identifier,
            for: indexPath) as? StatisticsViewCell else {
            fatalError("Error")
        }
        let result = gameResults.getResults()[indexPath.row]
        cell.configure(with: result)
        return cell
    }
}


extension StatisticsVC: StatisticsViewDelegate {
    @objc internal func cleanButtonTapped() {
        print("cleanButton tapped")
        gameResults.clearStatistics()
        updateUI()
    }
}


