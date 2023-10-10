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
