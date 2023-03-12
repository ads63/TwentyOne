//
//  Game.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 27.12.2022.
//

import Combine
import Foundation

final class Game: ObservableObject {
    static let winScore = 21
    static let stopDraw = 17
    var error: APIError? { didSet {
        DispatchQueue.main.async {
            self.isErrorPresented = self.error != nil
        }
    }}
    @Published var isErrorPresented = false
    @Published var winner: Winner = .unknown
    @Published var gameOver = false
    var players: [Player] = []
    let apiClient = APIClient()
    var subscriptions = Set<AnyCancellable>()
    var deckId: String?
    var drawCount: Int {
        players.filter { $0.isDrawEnabled }.count
    }

    init() {
        newGame()
    }

    /// to init new game
    func newGame() {
        error = nil
        winner = .unknown
        gameOver = false
        let player1 = Player(mode: .auto, showBack: true, game: self)
        let player2 = Player(mode: .manual, showBack: false, game: self)
        players = [player1,
                   player2]
        initDeck()
        Publishers.CombineLatest(player1.$cards, player2.$cards)
            .sink(receiveValue: { cards1, cards2 in
                self.checkWinner(firstCards: cards1, secondCards: cards2)
            })
            .store(in: &subscriptions)
    }

    /// add cards to players
    func drawCards() {
        guard let deckId = self.deckId,
              !deckId.isEmpty else { return }
        apiClient.drawCards(deckId: deckId,
                            count: self.players.filter { $0.isDrawEnabled }.count)?
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            }, receiveValue: { response in
                guard response.success
                else {
                    self.error = .invalidResponse
                    return
                }
                DispatchQueue.main.async {
                    let cards = response.cards
                    zip(cards, self.players.filter { $0.isDrawEnabled })
                        .forEach {
                            $1.cards.append($0)
                        }
                }
            }).store(in: &subscriptions)
    }

    /// get new deck, shuffle it, add the 1st card to the players
    private func initDeck() {
        apiClient.newDeck()?
            .replaceError(with: DeckResponse.defaultValue)
            .flatMap {
                guard $0.success,
                      let deckId = $0.deck_id,
                      !deckId.isEmpty
                else {
                    self.error = .invalidResponse
                    return Just(DeckResponse.defaultValue).eraseToAnyPublisher()
                }
                return (self.apiClient
                    .shuffleDeck(deckId: deckId, remaining: true)?.replaceError(with: DeckResponse.defaultValue).eraseToAnyPublisher()
                    ??
                    Just(DeckResponse.defaultValue).eraseToAnyPublisher())
            }
            .flatMap {
                guard $0.success,
                      $0.shuffled,
                      let deckId = $0.deck_id,
                      !deckId.isEmpty
                else {
                    self.error = .invalidResponse
                    self.deckId = nil
                    return Just(CardResponse.defaultValue).eraseToAnyPublisher()
                }
                self.deckId = deckId
                return self.apiClient.drawCards(deckId: deckId, count: self.drawCount)?
                    .replaceError(with: CardResponse.defaultValue)
                    .eraseToAnyPublisher() ??
                    Just(CardResponse.defaultValue)
                    .eraseToAnyPublisher()
            }
            .sink(receiveValue: {
                let response = $0 as CardResponse
                guard response.success,
                      response.cards.count == self.drawCount
                else {
                    self.error = .invalidResponse
                    return
                }
                DispatchQueue.main.async {
                    zip(response.cards, self.players.filter { $0.isDrawEnabled })
                        .forEach { $1.cards.append($0) }
                }
            })
            .store(in: &subscriptions)
    }
}

// different funcs for player & game state calculations
extension Game {
    /// check the completion condition of the game and determine the winner
    /// - Parameters:
    ///   - firstCards: first player cards array (application)
    ///   - secondCards: second player cards array (human)
    private func checkWinner(firstCards: [Card], secondCards: [Card]) {
        let firstScore = firstCards.map { $0.weight }.reduce(0,+)
        let secondScore = secondCards.map { $0.weight }.reduce(0,+)

        let firstState = calcPlayerState(result: firstScore)
        let secondState = calcPlayerState(result: secondScore)
        switch (firstState, secondState) {
        case (.continueGame, .continueGame),
             (.continueGame, .stopGame),
             (.stopGame, .continueGame):
            return // to continue the game
        case (.stopGame, .stopGame):
            switch (firstScore - secondScore).signum() {
            case 1:
                winner = .first
            case -1:
                winner = .second
            default:
                winner = .none
            }
        case (.wonGame, .wonGame),
             (.loseGame, .loseGame):
            winner = .none
        case (.wonGame, .continueGame),
             (.wonGame, .stopGame),
             (.wonGame, .loseGame),
             (.continueGame, .loseGame),
             (.stopGame, .loseGame):
            winner = .first
        case (.loseGame, .continueGame),
             (.loseGame, .stopGame),
             (.loseGame, .wonGame),
             (.continueGame, .wonGame),
             (.stopGame, .wonGame):
            winner = .second
        }
        finishGame() // to exit current game
    }

    /// Calc player's state
    /// - Parameter result: the sum of the player's cards
    /// - Returns: player state: draw card enabled (0...16)/ draw card disabled (17...20)/ won (21) / lost (>21)
    private func calcPlayerState(result: Int) -> PlayerState {
        switch result {
        case 0..<Game.stopDraw:
            return .continueGame
        case Game.stopDraw..<Game.winScore:
            return .stopGame
        case Game.winScore:
            return .wonGame
        default:
            return .loseGame
        }
    }

    /// on game over
    private func finishGame() {
        players.forEach {
            $0.showBack = false
        }
        gameOver = true
    }
}
