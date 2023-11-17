//
//  GameResult.swift
//  Rainbow-App
//
//  Created by Caroline Tikhomirova on 15.11.2023.
//

import Foundation

struct GameResult {
    
    let time: String
    let speed: Int
    let score: Int
    let totalWords: Int
    var orderNumber: Int
    
    init(time: String, speed: Int, score: Int, totalWords: Int) {
        self.time = time
        self.speed = speed
        self.score = score
        self.totalWords = totalWords
        self.orderNumber = 0
    }
}
