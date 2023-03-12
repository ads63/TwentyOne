//
//  CardResponse.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import Foundation

/// card set response
struct CardResponse: Codable {
    static let defaultValue = CardResponse(success: false, remaining: 0, cards: [])
    var success: Bool
    var deck_id: String?
    var remaining: Int
    var cards: [Card]
}
