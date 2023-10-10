//
//  XCTestExtension.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 08.10.2023.
//

import XCTest

extension XCTest {
    func feature(_ values: String...) {
        label(name: Allure.feature, values: values)
    }
    
    func  link(_ value: String) {
        links(name: value, values: [Allure.jiraUrl + value])
    }
    
    func story(_ stories: String...) {
        label(name: Allure.story, values: stories)
    }
    
    func severity(_ values: String...) {
        label(name: Allure.severity, values: values)
    }
    
    private func label(name: String, values: [String]) {
        for value in values {
            XCTContext.runActivity(named: Allure.label + name + ":" + value, block: {_ in })
        }
    }
    
    private func links(name: String, values: [String]) {
        for value in values {
            XCTContext.runActivity(named: Allure.link + name + ":" + value, block: {_ in})
        }
    }
}

enum Allure {
    static let link = "allure.link."
    static let label = "allure.label."
    static let severity = "severity"
    static let story = "story"
    static let jiraUrl = "https://jira.*.ru/testCase/"
    static let feature = "feature"
}
