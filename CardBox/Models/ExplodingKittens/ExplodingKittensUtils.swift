//
//  ExplodingKittensUtils.swift
//  CardBox
//
//  Created by mactest on 17/03/2022.
//

struct ExplodingKittensUtils {
    static let cardTypeKey = "CARD_TYPE"

    static let nonActionCards: Set<ExplodingKittensCardType> = [
        .random1,
        .random2,
        .random3
    ]
    static let actionCards: Set<ExplodingKittensCardType> = [
        .seeTheFuture,
        .shuffle,
        .skip,
        .favor,
        .attack,
        .nope
    ]
    static var playableCards: Set<ExplodingKittensCardType> {
        nonActionCards.union(actionCards)
    }

    static func getCardType(card: Card) -> ExplodingKittensCardType? {
        guard let typeParam = card.getAdditionalParams(key: cardTypeKey) else {
            return nil
        }
        return ExplodingKittensCardType(rawValue: typeParam)
    }

    static func setCardType(card: Card, type: ExplodingKittensCardType) {
        card.setAdditionalParams(key: cardTypeKey, value: type.rawValue)
    }
}
