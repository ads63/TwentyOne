//
//  GameView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 29.12.2022.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                CustomButton(title: "New game") {
                    game.newGame()
                }
                .frame(maxHeight: geometry.size.height * 0.04)
                Divider()
                PlayerView(player: game.players.first!)
                    .accessibilityIdentifier(AccessibilityIds.player1View)
                    .frame(maxHeight: geometry.size.height * 0.48)
                PlayerView(player: game.players.last!)
                    .accessibilityIdentifier(AccessibilityIds.player2View)
                    .frame(maxHeight: geometry.size.height * 0.48)
            }
            .padding(10)
        }
    }
}

// struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
// }
