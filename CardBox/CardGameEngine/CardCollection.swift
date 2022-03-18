//
//  CardCollection.swift
//  CardBox
//
//  Created by mactest on 10/03/2022.
//

typealias CardCombo = (_ cards: [Card]) -> [CardAction]

class CardCollection {
    private var cards: [Card] = []
    private var cardCombos: [CardCombo] = []

    var count: Int {
        cards.count
    }

    func addCardCombo(_ cardCombo: @escaping CardCombo) {
        self.cardCombos.append(cardCombo)
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
        Array(cards[0..<min(cards.count, n)])
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

    func addCard(_ card: Card, offsetFromTop index: Int) {
        cards.insert(card, at: index)
    }

    func containsCard(_ card: Card) -> Bool {
        containsCard(where: { $0 === card })
    }

    func getCards() -> [Card] {
        self.cards
    }

    func containsCard(where predicate: (Card) -> Bool) -> Bool {
        cards.contains(where: predicate)
    }

    func shuffle() {
        self.cards.shuffle()
    }
    
    func determineCardComboActions(_ cards: [Card]) -> [CardAction] {
        var cardComboActions: [CardAction] = []
        
        for cardCombo in cardCombos {
            cardComboActions.append(contentsOf: cardCombo(cards))
        }
        
        return cardComboActions
    }
}
