//
//  GameEnums.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 30.12.2022.
//

enum PlayerState {
    case continueGame, stopGame, wonGame, loseGame
}

enum Winner: String {
    case unknown = "The winner is unknown"
    case first = "You've lost"
    case second = "You've won"
    case none = "Neutral result"
}

enum PlayerMode {
    case auto, manual
}
