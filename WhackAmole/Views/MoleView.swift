//
//  MoleView.swift
//  WhackAmole
//
//  Created by MacBook Pro on 27/12/2024.
//

import SwiftUI

struct MoleView: View {
    @ObservedObject var mole: Mole
    @State private var isShaking: Bool = false
    let onHit: () -> Void
    
    var body: some View {
        ZStack {
            Image("mound")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            if mole.isVisible || mole.isHit {
                Image("diglet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(mole.isHit ? 60 : 0))
                    .opacity(mole.isHit ? 0 : 1)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.5), value: mole.isVisible)
                    .animation(.easeInOut(duration: 0.2), value: mole.isHit)
                    .onTapGesture {
                        handleHit()
                    }
            }
        }
    }
    
    private func handleHit() {
        mole.hit()  // Zgłoszenie trafienia do modelu
        onHit()
    }
}


