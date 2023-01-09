//
//  Method.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 26.12.2022.
//

import Foundation

/// enum to get API URLRequests
enum Method {
    static var baseUrlString = "https://deckofcardsapi.com/api/"
    case getDecks(Int)
    case drawCards(String, Int)
    case shuffleDeck(String, Bool)
    case newDeck
    var urlRequest: URLRequest? { switch self {
    case .getDecks(let count):
        return getDecksRequest(count: count)
    case .drawCards(let deckId, let count):
        return getDrawCardsRequest(deckId: deckId, count: count)
    case .shuffleDeck(let deckId, let remaining):
        return getShuffleDeckRequest(deckId: deckId, remainig: remaining)
    case .newDeck:
        return getNewDeckRequest()
    }
    }

    private func getNewDeckRequest() -> URLRequest? {
        guard let components =
            URLComponents(string: Method.baseUrlString.appending("deck/new/"))
        else {
            return nil
        }
        return URLRequest(url: components.url!)
    }

    private func getShuffleDeckRequest(deckId: String, remainig: Bool) -> URLRequest? {
        guard var components = URLComponents(string: Method.baseUrlString.appending("deck/\(deckId)/shuffle/")) else {
            return nil
        }
        components.queryItems = [URLQueryItem(name: "remaining", value: String(remainig))]
        return URLRequest(url: components.url!)
    }

    private func getDecksRequest(count: Int) -> URLRequest? {
        let urlString = Method.baseUrlString.appending("deck/new/shuffle/")
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [URLQueryItem(name: "deck_count", value: String(count))]
        return URLRequest(url: components.url!)
    }

    private func getDrawCardsRequest(deckId: String, count: Int) -> URLRequest? {
        let urlString = Method.baseUrlString.appending("deck/\(deckId)/draw/")
        guard var components = URLComponents(string: urlString) else {
            return nil
        }
        components.queryItems = [URLQueryItem(name: "count", value: String(count))]
        return URLRequest(url: components.url!)
    }
}
