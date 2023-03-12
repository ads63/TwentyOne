//
//  Card.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 27.12.2022.
//

import Foundation
struct Card: Codable {
    private static let weights = [
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "0": 10,
        "J": 2,
        "Q": 3,
        "K": 4,
        "A": 11
    ]
    var code: String
    var image: String
    var images: [String: String]
    var value: String
    var suit: String
    var weight: Int {
        guard let code = code.first else { return 0 }
        return Card.weights[String(code)] ?? 0
    }
}
