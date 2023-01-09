//
//  APIClient.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import Combine
import Foundation
import UIKit
struct APIClient {
    private let decoder = JSONDecoder()
    private let queue = DispatchQueue(label: "APIClient", qos: .default, attributes: .concurrent)

    /// get deck state data
    /// - Parameter count: count of 52card sets in the deck
    /// - Returns: publisher to subscribe to deck state data structured as DeckResponse
    func getDeck(count: Int) -> AnyPublisher<DeckResponse, APIError>? {
        guard let request = Method.getDecks(count).urlRequest else { return nil }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: queue)
            .map(\.data)
            .decode(type: DeckResponse.self, decoder: decoder)
            .mapError { error -> APIError in switch error {
            case is URLError:
                return APIError.unreachableAddress(url: request.url!)
            default:
                return APIError.invalidResponse
            }
            }
            .eraseToAnyPublisher()
    }

    /// draw cards from the deck
    /// - Parameters:
    ///   - deckId: id of the deck
    ///   - count: count of cards to draw
    /// - Returns: publisher to subscribe to drawn cards data structured as CardResponse
    func drawCards(deckId: String, count: Int) -> AnyPublisher<CardResponse, APIError>? {
        guard let request = Method.drawCards(deckId, count).urlRequest else { return nil }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: queue)
            .map(\.data)
            .decode(type: CardResponse.self, decoder: decoder)
            .mapError { error -> APIError in switch error {
            case is URLError:
                return APIError.unreachableAddress(url: request.url!)
            default:
                return APIError.invalidResponse
            }
            }
            .eraseToAnyPublisher()
    }

    /// shuffle the deck
    /// - Parameters:
    ///   - deckId: deck id
    ///   - remaining: true = shuffle only cards in the main stack,
    ///                false = shuffle main stack+ drawn cards+ all the piles
    /// - Returns: publisher to get deck state data structured as DeckResponse
    func shuffleDeck(deckId: String, remaining: Bool) -> AnyPublisher<DeckResponse, APIError>? {
        guard let request = Method.shuffleDeck(deckId, remaining).urlRequest else { return nil }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: queue)
            .map(\.data)
            .decode(type: DeckResponse.self, decoder: decoder)
            .mapError { error -> APIError in switch error {
            case is URLError:
                return APIError.unreachableAddress(url: request.url!)
            default:
                return APIError.invalidResponse
            }
            }
            .eraseToAnyPublisher()
    }

    /// get new deck of 52 cards
    /// - Returns: publisher to subscribe to deck state data structured as DeckResponse
    func newDeck() -> AnyPublisher<DeckResponse, APIError>? {
        guard let request = Method.newDeck.urlRequest else { return nil }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: queue)
            .map(\.data)
            .decode(type: DeckResponse.self, decoder: decoder)
            .mapError { error -> APIError in switch error {
            case is URLError:
                return APIError.unreachableAddress(url: request.url!)
            default:
                return APIError.invalidResponse
            }
            }
            .eraseToAnyPublisher()
    }
}

enum APIError: LocalizedError {
    case unreachableAddress(url: URL)
    case invalidResponse
    var errorDescription: String? { switch self {
    case .unreachableAddress(let url): return "\(url.absoluteString) is unreachable"
    case .invalidResponse: return "Response with mistake"
    }
    }
}
