//
//  GridView.swift
//  WhackAmole
//
//  Created by MacBook Pro on 27/12/2024.
//

import Foundation

import SwiftUI

struct GridView: View {
    @Binding var moles: [Mole]
    let action: (Mole) -> Void
    
    private let columns = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(moles.indices, id: \.self) { index in
                MoleView(mole: moles[index]) {
                    action(moles[index])
                }
            }
        }
    }
}
