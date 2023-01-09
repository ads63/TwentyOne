//
//  GameOverView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 29.12.2022.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var game: Game
    var body: some View {
        VStack {
            Text("Game results")
                .font(.largeTitle)
            Text(game.winner.rawValue)
                .font(.title)
                .bold()
                .foregroundColor(game.winner == .first ?.red :
                    game.winner == .second ? .green : .gray)
            CardsView(player: game.players.first!)
                .padding(32)
            CardsView(player: game.players.last!)
            CustomButton(title: "New game") {
                game.newGame()
            }
        }
        .padding(32)
    }
}

// struct GameOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameOverView()
//    }
// }
