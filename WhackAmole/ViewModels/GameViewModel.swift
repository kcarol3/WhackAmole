import Foundation
import Combine

class GameViewModel: ObservableObject {
    @Published var moles: [Mole] = Array(repeating: Mole(), count: 9)
    @Published var gameData = GameData()
    private var timer: Timer?
    private var moleTimer: Timer?
    
    @Published var highScores: [Score] = []
    
    private let maxScores = 5
    
    func addHighScore(_ score: Score) {
        highScores.append(score)
        highScores.sort { $0.points > $1.points }
        if highScores.count > 5 {
            highScores.removeLast()
        }
    }
    
    private func saveHighScores() {
        if let encoded = try? JSONEncoder().encode(highScores) {
            UserDefaults.standard.set(encoded, forKey: "highScores")
        }
    }
    
    func loadHighScores() {
        if let data = UserDefaults.standard.data(forKey: "highScores"),
           let decoded = try? JSONDecoder().decode([Score].self, from: data) {
            highScores = decoded
        }
    }
    
    func clearHighScores() {
            highScores.removeAll()
            saveHighScores()
        }
    
    func startGame() {
        gameData = GameData()
        startTimers()
    }
    
    private func startTimers() {
        timer?.invalidate()
        moleTimer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.gameData.timeRemaining -= 1
            if self.gameData.timeRemaining <= 0 {
                self.timer?.invalidate()
                self.moleTimer?.invalidate()
                self.moles = self.moles.map { _ in
                    Mole(isVisible: false)
                }
                self.gameData.isGameOver = true
            }
        }
        
        moleTimer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { [weak self] _ in
            self?.toggleMoles()
        }
    }
    
    private func toggleMoles() {
        moles = moles.map { _ in
            Mole(isVisible: Bool.random())
        }
    }
    
    func hitMole(_ mole: Mole) {
        if let index = moles.firstIndex(where: { $0.id == mole.id }), moles[index].isVisible {
            moles[index].isVisible = false
            gameData.score += 1
        }
    }
    
    func endGame(playerName: String) {
        timer?.invalidate()
        moleTimer?.invalidate()
        let newScore = Score(playerName: playerName, points: gameData.score)
        addHighScore(newScore)
        saveHighScores()
    }
}
