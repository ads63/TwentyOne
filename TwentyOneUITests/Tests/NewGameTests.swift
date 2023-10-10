//
//  NewGameTests.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 10.10.2023.
//

import XCTest

final class NewGameTests: BaseTest {

    func testAutoButton() {
        let page = GameScreen()
        
        step("Given app is running in foreground ") { _ in
    
            XCTAssertEqual(page.app.state, .runningForeground)
        }
        
        step("Then check Auto button exists & disabled") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: Predicates.disabled, object: page.autoButton)
            let result = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
            XCTAssertEqual(result, .completed)
        }
    }
    
    func testNewGameButton() {
        let page = GameScreen()
        
        step("Given app is running in foreground ") { _ in
            XCTAssertEqual(page.app.state, .runningForeground)
        }
        
        step("Then check New Game button exists & enabled") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: Predicates.enabled, object: page.newGameButton)
            let result = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
            XCTAssertEqual(result, .completed)
        }
    }
    
    func testDrawCardsButton() {
        let page = GameScreen()
        
        step("Given app is running in foreground ") { _ in
            XCTAssertEqual(page.app.state, .runningForeground)
        }
        
        step("Then check Draw cards button exists & enabled") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: Predicates.enabled, object: page.drawCardsButton)
            let result = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
            XCTAssertEqual(result, .completed)
        }
    }
    
    func testPlayerCardsView() {
        let page = GameScreen()
        
        step("Given app is running in foreground ") { _ in
            XCTAssertEqual(page.app.state, .runningForeground)
        }
        step("Then check players initial cards count  ") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: Predicates.visible, object: page.player2Cards)
            let _ = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
            XCTAssertEqual(page.cards.count, 2)
        }

    }
}
