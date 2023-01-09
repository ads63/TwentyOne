//
//  CardResponse.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import Foundation
/// card set response
public struct CardResponse: Codable {
    public static let defaultValue = CardResponse(success: false, remaining: 0, cards: [])
    public var success: Bool
    public var deck_id: String?
    public var remaining: Int
    public var cards: [Card]
}
