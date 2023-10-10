//
//  GameScreen.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 03.10.2023.
//

import XCTest

class GameScreen: BaseScreen {
    private lazy var buttons = findAll(.button)
    private lazy var texts = findAll(.staticText)
    lazy var newGameButton = app.buttons[UIConstants.newGameButton]
    lazy var autoButton = app.buttons[UIConstants.autoButton]
    lazy var drawCardsButton = app.buttons[UIConstants.drawCardsButton]
    lazy var gameResaultsLabal = app.staticTexts[UIConstants.gameResultsLabel]
    lazy var cards = findAll(.image).allElementsBoundByIndex
//    lazy var player1Cards =  findAll(.image).matching(NSPredicate(format: "identifier == 'player1View'")).allElementsBoundByIndex
//    // findAll(.image).matching(identifier: "player1View").allElementsBoundByIndex
    lazy var player2Cards = findAll(.image).matching(NSPredicate(format: "identifier == 'player2View'")).allElementsBoundByIndex
}
