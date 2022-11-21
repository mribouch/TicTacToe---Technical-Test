//
//  ContentView.swift
//  TicTacToe
//
//  Created by Martin Ribouchon on 21/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    @State var timerText = ""
    var items: [GridItem] = [GridItem(.flexible()),
                             GridItem(.flexible()),
                             GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text(timerText)
                        .padding(.bottom, 50)
                        .onReceive(game.timer) { time in
                            timerText = game.handleTimer()
                        }
                    HStack {
                        if game.player1.play {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.green)
                        }
                        Text("Player 1: \(game.player1.point) - \(game.player1.char)")
                    }
                    HStack {
                        if game.player2.play {
                            Image(systemName: "arrow.right")
                                .foregroundColor(.green)
                        }
                        Text("Player 2: \(game.player2.point) - \(game.player2.char)")
                    }
                    
                }
                .padding()
                
                ZStack {
                    LazyVGrid(columns: items, spacing: 10) {
                        ForEach(0..<9, id: \.self) { n in
                            if game.board[n] == "" {
                                Rectangle()
                                    .padding()
                                    .background(Color.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: 40, height: 40)
                                    .onTapGesture {
                                        game.play(at: n)
                                    }
                            } else {
                                Image(systemName: game.board[n] == game.player1.char ? "x.square.fill" : "circle")
                                    .font(.system(size: 40))
                                    .padding()
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                }
            }
            .navigationTitle("TicTacToe")
            .alert(game.gameOverAlert() , isPresented: $game.playerHasWin) {
                Button("Restart") {
                    game.restartGame()
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
