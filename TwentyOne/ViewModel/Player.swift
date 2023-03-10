//
//  Player.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 27.12.2022.
//

import Combine
import Foundation

final class Player: ObservableObject {
    var mode: PlayerMode
    @Published var showBack: Bool
    @Published var cards: [Card] = [] { didSet {
        showBack = showBack && isDrawEnabled
    }}
    let game: Game?
    var isDrawEnabled: Bool {
        cards.map { $0.weight }.reduce(0, +) < Game.stopDraw
    }

    init(mode: PlayerMode, showBack: Bool, game: Game) {
        self.mode = mode
        self.showBack = showBack
        self.game = game
    }
}
