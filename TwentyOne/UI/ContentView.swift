//
//  ContentView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()

    @ViewBuilder
    var body: some View {
        if game.isErrorPresented {
            ErrorView(game: game)
        } else {
            if game.gameOver {
                GameOverView(game: game)
            } else {
                GameView(game: game)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
