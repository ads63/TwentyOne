//
//  PlayerView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 27.12.2022.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var player: Player

    var body: some View {
        VStack {
            CardsView(player: player)
            .accessibilityIdentifier(AccessibilityIds.cardsView)
            Spacer()
            CustomButton(title: player.mode == .manual ? "Draw cards" : "Auto") {
                player.game?.drawCards()
            }
            .disabled(player.mode == .auto)
            .frame(maxHeight: 16.0)
            .padding(10)
        }
    }
}

// struct PlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerView(player: Player(mode: .manual, showBack: false))
//    }
// }
