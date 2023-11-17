//
//  Results.swift
//  Rainbow-App
//
//  Created by Caroline Tikhomirova on 15.11.2023.
//

import Foundation

class Results {
    
    var results: [GameResult] = []
    
    func getResults() -> [GameResult] {
        return results
    }
    
    func addResult(time: String, speed: Int, score: Int, totalWords: Int) {
        var result = GameResult(time: time, speed: speed, score: score, totalWords: totalWords)
        result.orderNumber = results.count + 1
        results.insert(result, at: 0)
    }
    
    func clearStatistics() {
        results.removeAll()
    }
}
