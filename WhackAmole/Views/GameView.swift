//
//  GameView.swift
//  WhackAmole
//
//  Created by MacBook Pro on 27/12/2024.
//
import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var playerName: String = ""
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.gameData.score)")
                .font(.largeTitle)
                .padding()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.green, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: CGFloat(viewModel.gameData.timeRemaining) / CGFloat(viewModel.gameData.startTime) * UIScreen.main.bounds.width, height: 20)
                    .animation(.linear(duration: 1), value: viewModel.gameData.timeRemaining)
            }
            .padding()
            
            Text("Time: \(viewModel.gameData.timeRemaining)")
                .font(.headline)
                .padding()
            
            
            GridView(moles: $viewModel.moles) { mole in
                viewModel.hitMole(mole)
            }
            
            Spacer()
            
            if viewModel.gameData.isGameOver {
                VStack {
                    Text("Game Over")
                        .font(.title)
                        .padding()
                    
                    TextField("Enter your name", text: $playerName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.words)
                }
            }
        }
        .onDisappear {
            if viewModel.gameData.isGameOver {
                if playerName == "" {
                    playerName = "Anonymus"
                }
                viewModel.endGame(playerName: playerName)
            }
        }
    }
}

