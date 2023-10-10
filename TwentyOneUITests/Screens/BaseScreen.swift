//
//  BaseScreen.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 03.10.2023.
//

import XCTest

protocol BaseScreen {
}

extension BaseScreen {
    func findAll(_ type: XCUIElement.ElementType) -> XCUIElementQuery {
        return app.descendants(matching: type)
    }
    

    func takeScreenshot() {
       XCTContext.runActivity(named: "Screenshot") { activity in
          let screenshot = app.screenshot()
          let attachment = XCTAttachment(screenshot: screenshot)
          attachment.lifetime = .keepAlways
          activity.add(attachment)
       }
    }

    var app: XCUIApplication {
        return XCUIApplication()
    }
}
