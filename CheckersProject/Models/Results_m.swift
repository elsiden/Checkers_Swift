//
//  Results_m.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 01.12.2021.
//

import UIKit

class Results_m: Equatable {
    static func == (lhs: Results_m, rhs: Results_m) -> Bool {
        return lhs.player1 == rhs.player1 && lhs.player2 == rhs.player2
    }

    var player1: String?
    var player2: String?
    var winner: String?
    var gameTime: String?
    var gameDate: String?
    
    init(from result: Results) {
        self.player1 = result.player1
        self.player2 = result.player2
        self.winner = result.winner
        self.gameTime = result.gameTime
        self.gameDate = result.gameDate
    }
    
    init(player1: String, player2: String, winner: String, gameTime: String, gameDate: String) {
        self.player1 = player1
        self.player2 = player2
        self.winner = winner
        self.gameTime = gameTime
        self.gameDate = gameDate
    }
}
