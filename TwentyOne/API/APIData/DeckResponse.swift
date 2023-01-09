//
//  DeckResponse.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import Combine
import UIKit

/// deck state response
public struct DeckResponse: Codable {
    public static let defaultValue = DeckResponse(success: false, remaining: 0, shuffled: false)
    public var success: Bool
    public var deck_id: String?
    public var remaining: Int
    public var shuffled: Bool
}
