//
//  Game.swift
//  TicTacToe
//
//  Created by Martin Ribouchon on 21/11/2022.
//

import Foundation

class Game: ObservableObject {
    @Published var board: [String] = ["", "", "", "", "", "", "", "", ""]
    var player1 = Player(char: "X", play: true)
    var player2 = Player(char: "O")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var playerHasWin = false
    
    var timeRemaining = 180
    
    var playerPlaying: Player {
        player1.play ? player1 : player2
    }
    
    func play(at index: Int) -> Void {
        print("player played: \(playerPlaying.char)")
        board[index] = playerPlaying.char
        checkBoard(char: playerPlaying.char)
        switchTurn()
    }
    
    func switchTurn() -> Void {
        player1.play.toggle()
        player2.play.toggle()
    }
    
    private func checkBoard(char: String) -> Void {
        checkRows(char: char)
        checkColumns(char: char)
        checkDiags(char: char)
    }
    
    private func checkRows(char: String) -> Void {
        var count = 0
        
        for i in 0..<9 {
            if board[i] == char { count += 1 } else { count = 0 }
            if count == 3 {
                roundWin()
                return
            }
            if (i + 1) % 3 == 0 { count = 0 }
        }
    }
    
    private func checkColumns(char: String) -> Void {
        var count = 0
        
        for i in 0..<3 {
            for j in 0..<3 {
                if board[i + j * 3] == char { count += 1 } else { count = 0 }
                if count == 3 {
                    roundWin()
                    return
                }
            }
            count = 0
        }
    }
    
    private func checkDiags(char: String) -> Void {
        let diag1 = [0, 4, 8]
        let diag2 = [2, 4, 6]
        var count = 0
        
        for index in diag1 {
            if board[index] == char { count += 1 } else { count = 0 }
            if count == 3 {
                roundWin()
                return
            }
        }
        
        for index in diag2 {
            if board[index] == char { count += 1 } else { count = 0 }
            if count == 3 {
                roundWin()
                return
            }
        }
    }
    
    private func roundWin() -> Void {
        playerPlaying == player1 ? player1.winRound() : player2.winRound()
        refreshBoard()
    }
    
    private func refreshBoard() -> Void {
        board = ["", "", "", "", "", "", "", "", ""]
    }
    
    func handleTimer() -> String {
        timeRemaining -= 1
        if timeRemaining < 0 { timeRemaining = 0 }
        
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        
        if timeRemaining <= 0 {
            gameOver()
        }
        
        let secondsText: String = seconds < 10 ? "0\(seconds)" : String(seconds)
        return "0\(minutes):\(secondsText)"
    }
    
    func gameOver() {
        playerHasWin = true
    }
    
    func restartGame() {
        refreshBoard()
        player1.resetPoint()
        player2.resetPoint()
        timeRemaining = 180
    }
    
    func gameOverAlert() -> String {
        var playerText = ""
        var scoreText = ""
        var winText = ""
        
        
        if player1.point > player2.point {
            playerText = "Player 1!"
            scoreText = "\(player1.point)/\(player2.point)"
            winText = "Winner: " + playerText + " " + scoreText
        } else if player2.point > player1.point {
            playerText = "Player 2!"
            scoreText = "\(player2.point)/\(player1.point)"
            winText = "Winner: " + playerText + " " + scoreText
        } else {
            winText = "Deuce"
        }
        
        return winText
    }
}
