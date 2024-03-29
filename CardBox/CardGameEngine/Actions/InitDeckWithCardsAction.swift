struct InitDeckWithCardsAction: Action {
    let cards: [Card]

    func executeGameEvents(gameRunner: GameRunnerReadOnly) {
        // Only can be used in init phase
        guard gameRunner.state == .initialize else {
            return
        }

        let addCards: [GameEvent] = cards.map { card in
            AddCardToDeckEvent(card: card)
        }

        gameRunner.executeGameEvents(addCards)
    }
}
