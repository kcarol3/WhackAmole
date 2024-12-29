//
//  ScoreModel.swift
//  WhackAmole
//
//  Created by MacBook Pro on 27/12/2024.
//
import SwiftUI

struct Score: Identifiable, Codable {
    var id: UUID = UUID()
    let playerName: String
    let points: Int
}
