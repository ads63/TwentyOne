//
//  DeckResponse.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import Combine
import UIKit

/// deck state response
struct DeckResponse: Codable {
    static let defaultValue = DeckResponse(success: false, remaining: 0, shuffled: false)
    var success: Bool
    var deck_id: String?
    var remaining: Int
    var shuffled: Bool
}
