//
//  Predicates.swift
//  TwentyOneUITests
//
//  Created by Алексей Шинкарев on 10.10.2023.
//

import Foundation

enum Predicates {
    static let enabled = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
    static let disabled = NSPredicate(format: "exists == true AND hittable == true AND enabled == false")
    static let visible = NSPredicate(format: "exists == true AND hittable == true")
    static let existsPredicate = NSPredicate(format: "exists == true")
}
