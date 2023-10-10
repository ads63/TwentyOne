//
//  TwentyOneTests.swift
//  TwentyOneTests
//
//  Created by Алексей Шинкарев on 31.12.2022.
//

import Combine
@testable import TwentyOne
import XCTest

final class TwentyOneTests: XCTestCase {
    var game: Game!
    var subscriptions: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        subscriptions = Set<AnyCancellable>()
        game = Game()
    }

    override func tearDown() {
        game = nil
        subscriptions = nil
        super.tearDown()
    }

    /// Test initial game state
    func testInitialGameState() throws {
        game.newGame()
        let expected = [1, 1]
        let expectation = self.expectation(description: "The number of cards at the beginning of the game must be equal to 1")
        Publishers.CombineLatest(game.players.first!.$cards, game.players.last!.$cards)
            .sink(receiveValue: { cards1, cards2 in
                if [cards1.count, cards2.count].elementsEqual(expected) { expectation.fulfill() }
            })
            .store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        XCTAssertEqual(game.winner, .unknown, "Invalid winner state \(game.winner) ")
        XCTAssertFalse(game.gameOver, "Invalid initial game state \(game.gameOver)")
        XCTAssertEqual(game.players.count, 2, "Invalid count of players \(game.players.count)")
    }

    /// Test game iteration results
    func testGameIterationState() throws {
        game.newGame()
        let expected = [2, 2]
        let expectation = self.expectation(description: "The number of cards after the first game iteration must be equal to 2")
        Publishers.CombineLatest(game.players.first!.$cards, game.players.last!.$cards)
            .sink(receiveValue: { cards1, cards2 in
                if [cards1.count, cards2.count].elementsEqual(expected) { expectation.fulfill() }
            })
            .store(in: &subscriptions)
        game.drawCards()
        waitForExpectations(timeout: 15)
    }

    /// Test game final state
    func testFinalGameState() throws {
        let maxGameIterations = 8
        var isGameOver = false
        var iterationCounter = 0

        game.newGame()
        let expectation = self.expectation(description: "Game is finished")
        game.$gameOver.sink(receiveValue: {
            if $0 != isGameOver {
                isGameOver = true
                expectation.fulfill()
            }

        }).store(in: &subscriptions)

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if isGameOver || iterationCounter >= maxGameIterations { timer.invalidate() }
            else { self.game.drawCards() }
            iterationCounter += 1
        }
        waitForExpectations(timeout: 20)
        XCTAssertTrue(game.gameOver, "Invalid game over state \(game.gameOver)")
        XCTAssertTrue(game.winner != .unknown, "Invalid winner value \(game.winner.rawValue)")
        let score1 = game.players.first!.cards.map { $0.weight }.reduce(0,+)
        let score2 = game.players.last!.cards.map { $0.weight }.reduce(0,+)
        switch game.winner {
        case .none:
            XCTAssertTrue(checkNoWinnerScore(first: score1, second: score2), "Invalid scores \(score1), \(score2) for result \(game.winner.rawValue) ")
        case .first:
            XCTAssertTrue(checkFirstWinnerScore(first: score1, second: score2), "Invalid scores \(score1), \(score2) for result \(game.winner.rawValue) ")
        case .second:
            XCTAssertTrue(checkSecondWinnerScore(first: score1, second: score2), "Invalid scores \(score1), \(score2) for result \(game.winner.rawValue) ")
        default:
            XCTAssertTrue([.none, .first, .second].contains { $0 == game.winner }, "Invalid winner \(game.winner.rawValue)")
        }
        func checkNoWinnerScore(first: Int, second: Int) -> Bool {
            return ((Game.stopDraw ..< Game.winScore).contains(first)
                && (Game.stopDraw ..< Game.winScore).contains(second)
                && first == second)
                || (first == Game.winScore && second == Game.winScore)
                || (first > Game.winScore && second > Game.winScore)
        }
        func checkFirstWinnerScore(first: Int, second: Int) -> Bool {
            return ((Game.stopDraw ..< Game.winScore).contains(first)
                && (Game.stopDraw ..< Game.winScore).contains(second)
                && first > second)
                || (first <= Game.winScore && second > Game.winScore)
                || (first == Game.winScore && second != Game.winScore)
        }
        func checkSecondWinnerScore(first: Int, second: Int) -> Bool {
            return ((Game.stopDraw ..< Game.winScore).contains(first)
                && (Game.stopDraw ..< Game.winScore).contains(second)
                && first < second)
                || (first > Game.winScore && second <= Game.winScore)
                || (first != Game.winScore && second == Game.winScore)
        }
    }
}
