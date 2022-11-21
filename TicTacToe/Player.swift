//
//  Player.swift
//  TicTacToe
//
//  Created by Martin Ribouchon on 21/11/2022.
//

import Foundation

struct Player: Equatable {
    let char: String
    var point = 0
    var play = false
    
    mutating func winRound() -> Void {
        point += 1
    }
    
    mutating func resetPoint() -> Void {
        point = 0
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.char == rhs.char
    }
}
