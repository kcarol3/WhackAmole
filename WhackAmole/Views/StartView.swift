//
//  StartView.swift
//  WhackAmole
//
//  Created by MacBook Pro on 27/12/2024.
//

import SwiftUI

struct StartView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var isGameActive = false
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Whack-a-Mole")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5) // Cień
                    .padding()
                
                NavigationLink(
                    destination: GameView(viewModel: viewModel),
                    isActive: $isGameActive
                ) {
                    EmptyView()
                }
                
                Spacer()
                
                VStack {
                    Text("High Scores")
                        .font(.title2)
                        .padding(.top)
                    List(viewModel.highScores) { score in
                        HStack {
                            Text(score.playerName)
                            Spacer()
                            Text("\(score.points) pts")
                        }
                    }
                    .frame(height: 300)
                }
                .gesture(
                    LongPressGesture()
                        .onEnded { _ in
                            showConfirmation = true
                        }
                )
                .alert(isPresented: $showConfirmation) {
                    Alert(
                        title: Text("Clear High Scores"),
                        message: Text("Are you sure you want to clear all high scores?"),
                        primaryButton: .destructive(Text("Clear")) {
                            viewModel.clearHighScores()
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                Spacer()
                
                Button("Start Game") {
                    startGame()
                }
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(){
            viewModel.loadHighScores()
        }
    }
    
    private func startGame() {
        isGameActive = true
        viewModel.startGame()
    }
}


