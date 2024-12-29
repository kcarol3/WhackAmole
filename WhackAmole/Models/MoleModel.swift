//
//  WhackAmoleModel.swift
//  WhackAmole
//
//  Created by MacBook Pro on 27/12/2024.
//

import Foundation
import SwiftUI

class Mole: ObservableObject, Identifiable {
    let id = UUID()
    @Published var isVisible: Bool = false
    @Published var isHit: Bool = false
    
    init(isVisible: Bool = false) {
        self.isVisible = isVisible
    }

    func hit() {
        guard isVisible, !isHit else { return }
        isHit = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.isVisible = false
            self.isHit = false
        }
    }
}

