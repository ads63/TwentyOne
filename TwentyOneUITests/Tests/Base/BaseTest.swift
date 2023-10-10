//
//  BaseTest.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 03.10.2023.
//

import XCTest

class BaseTest: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUp() {

        continueAfterFailure = true
        app.launch()
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5),Messages.invalidAppState)
    }
    
    func testPrintTree() {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["Draw cards"]/*[[".buttons[\"Draw cards\"]",".buttons[\"player2View\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        app.buttons["New game"].tap()
        print(app.debugDescription)
    }
    
    func step(_ name: String, block: (XCTActivity) -> Void) {
        XCTContext.runActivity(named: name, block: block)
    }
    
    override func tearDownWithError() throws {
        
        let screenshot = XCUIScreen.main.screenshot()
        let screenshotAttachment = XCTAttachment(screenshot: screenshot)
        screenshotAttachment.lifetime = .deleteOnSuccess
        add(screenshotAttachment)
        app.terminate()
    }

}
