//
//  GameIterationsTest.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 10.10.2023.
//

import XCTest

final class GameIterationsTests: BaseTest {


    func testIterations() {
        let page = GameScreen()
        let maxIterations = 8
        var isGameOver = false
        step("Given app is running in foreground ") { _ in
            XCTAssertEqual(page.app.state, .runningForeground)
        }
        
        step("Then check Draw cards button exists & enabled") { _ in
            let expectation = XCTNSPredicateExpectation(predicate: Predicates.enabled, object: page.drawCardsButton)
            let result = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
            XCTAssertEqual(result, .completed)
        }
        
        for iteration in 1...maxIterations {
            step("Draw card iteration \(iteration)") { _ in
                let cardsBefore =  page.cards.count
                page.drawCardsButton.tap()
                                            
                if !page.gameResaultsLabal.exists {
                    step("Then check  cards count") { _ in
                        let expectation = XCTNSPredicateExpectation(predicate: Predicates.visible, object: page.cards)
                        let _ = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
                        XCTAssertGreaterThanOrEqual(page.cards.count, cardsBefore)
                    }
                } else {isGameOver = true}
            }
            if isGameOver { break }
        }
        let expectation = XCTNSPredicateExpectation(predicate: Predicates.enabled, object: page.newGameButton)
        let result = XCTWaiter.wait(for: [expectation], timeout: Timeouts.standard)
        XCTAssertEqual(result, .completed)
        
    }
    
}
