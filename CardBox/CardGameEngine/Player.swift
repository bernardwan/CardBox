//
//  Player.swift
//  CardBox
//
//  Created by mactest on 10/03/2022.
//

typealias PlayerPlayCondition = (_ gameRunner: GameRunnerReadOnly, _ cards: [Card], _ player: Player) -> Bool

class Player: Identifiable {
    private(set) var hand: CardCollection
    private(set) var name: String
    private(set) var isOutOfGame = false

    private(set) var cardsPlayed = 0

    private var canPlayConditions: [PlayerPlayCondition]

    var description: String {
        name
    }

    init(name: String) {
        self.hand = CardCollection()
        self.name = name

        self.canPlayConditions = []
    }

    func addCard(_ card: Card) {
        guard !isOutOfGame else {
            return
        }

        self.hand.addCard(card)
    }

    func removeCard(_ card: Card) {
        guard !isOutOfGame else {
            return
        }

        self.hand.removeCard(card)
    }

    func getHand() -> CardCollection {
        self.hand
    }

    func hasCard(_ card: Card) -> Bool {
        guard !isOutOfGame else {
            return false
        }

        return hand.containsCard(card)
    }

    func hasCard(where predicate: (Card) -> Bool) -> Bool {
        guard !isOutOfGame else {
            return false
        }

        return hand.containsCard(where: predicate)
    }

<<<<<<< HEAD
    func addCanPlayCondition(_ condition: @escaping PlayerPlayCondition) {
=======
    func addCanPlayCondition(_ condition: PlayerPlayCondition) {
>>>>>>> f934cefe771b291b2ad8cdd39666a5565116b753
        self.canPlayConditions.append(condition)
    }

    func canPlay(cards: [Card], gameRunner: GameRunnerReadOnly) -> Bool {
<<<<<<< HEAD
        canPlayConditions.allSatisfy({ $0(gameRunner, cards, self) })
    }

    func playCards(_ cards: [Card], gameRunner: GameRunnerReadOnly, on target: GameplayTarget) {
        let action = PlayCardAction(player: self, cards: cards, target: target)
        ActionDispatcher.runAction(action, on: gameRunner)
=======
        let args = PlayerPlayConditionArgs(cards: cards, player: self)
        return canPlayConditions.allSatisfy({ condition in
            condition.evaluate(gameRunner: gameRunner, args: args)
        })
    }

    func endTurn(gameRunner: GameRunnerReadOnly) {
        guard !isOutOfGame else {
            return
        }

        ActionDispatcher.runAction(EndTurnAction(), on: gameRunner)
>>>>>>> f934cefe771b291b2ad8cdd39666a5565116b753
    }

    func playCards(_ cards: [Card], gameRunner: GameRunnerReadOnly, on target: GameplayTarget) {
        let action = PlayCardAction(player: self, cards: cards, target: target)
        ActionDispatcher.runAction(action, on: gameRunner)
    }

    func getCardByIndex(_ index: Int) -> Card? {
        guard !isOutOfGame else {
            return nil
        }

        return hand.getCardByIndex(index)
    }

    func setOutOfGame(_ outOfGame: Bool) {
        self.isOutOfGame = outOfGame
    }

    func incrementCardsPlayed() {
        self.cardsPlayed += 1
    }

    func resetCardsPlayed() {
        self.cardsPlayed = 0
    }
}
