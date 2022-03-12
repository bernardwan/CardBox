//
//  CardCollection.swift
//  CardBox
//
//  Created by mactest on 10/03/2022.
//

class CardCollection {
    private var cards: [Card] = []

    init() {

    }

    func getFirstCard() -> Card? {
        if cards.isEmpty {
            return nil
        }
        return cards[0]
    }

    func getCardByIndex(_ index: Int) -> Card? {
        if index < 0 || index >= cards.count {
            return nil
        }

        return cards[index]
    }

    func getTopNCards(n: Int) -> [Card] {
        Array(cards[0..<n])
    }

    func removeCard(_ card: Card) {
        guard let cardIndex = cards.firstIndex(where: { $0 === card }) else {
            return
        }
        cards.remove(at: cardIndex)
    }

    func addCard(_ card: Card) {
        cards.append(card)
    }

    func addCard(_ card: Card, at index: Int) {
        cards.insert(card, at: index)
    }

    func getCards() -> [Card] {
        self.cards
    }

    func shuffle() {
        self.cards.shuffle()
    }
}