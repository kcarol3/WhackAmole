//
//  ContentView.swift
//  WhackAmole
//
//  Created by MacBook Pro on 17/12/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        StartView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
