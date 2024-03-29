//
//  GameRunner.swift
//  CardBox
//
//  Created by mactest on 10/03/2022.
//

import SwiftUI

class GameRunner: GameRunnerReadOnly, GameRunnerInitOnly, GameRunnerUpdateOnly, ObservableObject {
    @Published internal var deck: CardCollection
    @Published internal var players: PlayerCollection
    @Published internal var gameplayArea: CardCollection
    @Published internal var state: GameState
    @Published internal var cardPreview: Card?
    @Published internal var cardsPeeking: [Card]
    @Published internal var isShowingPeek = false
    @Published internal var isWin = false
    internal var winner: Player?

    // Exploding kitten specific variables
    @Published internal var isShowingDeckPositionRequest = false
    @Published internal var isShowingPlayerHandPositionRequest = false
    @Published internal var isShowingCardTypeRequest = false
    internal var deckPositionRequestArgs: DeckPositionRequestArgs?
    internal var playerHandPositionRequestArgs: PlayerHandPositionRequestArgs?
    internal var cardTypeRequestArgs: CardTypeRequestArgs?

    private var onSetupActions: [Action]
    private var onStartTurnActions: [Action]
    private var onEndTurnActions: [Action]
    private var onAdvanceNextPlayerActions: [Action]
    private var nextPlayerGenerator: NextPlayerGenerator?
    private var winningConditions: [WinningCondition]
    private var winnerGenerator: WinnerGenerator?

    init() {
        self.deck = CardCollection()
        self.onSetupActions = []
        self.onStartTurnActions = []
        self.onEndTurnActions = []
        self.gameplayArea = CardCollection()
        self.players = PlayerCollection()
        self.state = .initialize
        self.cardsPeeking = []
        self.nextPlayerGenerator = nil
        self.winningConditions = []
        self.onAdvanceNextPlayerActions = []
    }

    func addSetupAction(_ action: Action) {
        self.onSetupActions.append(action)
    }

    func addStartTurnAction(_ action: Action) {
        self.onStartTurnActions.append(action)
    }

    func addEndTurnAction(_ action: Action) {
        self.onEndTurnActions.append(action)
    }

    func addWinningCondition(_ condition: WinningCondition) {
        self.winningConditions.append(condition)
    }

    func setWinnerGenerator(_ generator: WinnerGenerator) {
        self.winnerGenerator = generator
    }

    func addAdvanceNextPlayerAction(_ action: Action) {
        self.onAdvanceNextPlayerActions.append(action)
    }

    func setNextPlayerGenerator(_ generator: NextPlayerGenerator) {
        self.nextPlayerGenerator = generator
    }

    func checkWinningConditions() -> Bool {
        winningConditions.allSatisfy({ $0.evaluate(gameRunner: self) })
    }

    func setup() {
        self.onSetupActions.forEach { action in
            action.executeGameEvents(gameRunner: self)
        }
    }

    func onStartTurn() {
        self.onStartTurnActions.forEach { action in
            action.executeGameEvents(gameRunner: self)
        }
    }

    func onEndTurn() {
        self.onEndTurnActions.forEach { action in
            action.executeGameEvents(gameRunner: self)
        }
    }

    func onAdvanceNextPlayer() {
        self.onAdvanceNextPlayerActions.forEach { action in
            action.executeGameEvents(gameRunner: self)
        }
    }

    func executeGameEvents(_ gameEvents: [GameEvent]) {
        gameEvents.forEach { gameEvent in
            gameEvent.updateRunner(gameRunner: self)
        }
        notifyChanges()

        if checkWinningConditions() {
            self.isWin = true
            self.winner = winnerGenerator?.getWinner(gameRunner: self)
        }
    }

    func setGameState(gameState: GameState) {
        self.state = gameState
    }

    func notifyChanges() {
        objectWillChange.send()
    }

    func endPlayerTurn() {
        ActionDispatcher.runAction(EndTurnAction(), on: self)
    }

    func setCardsPeeking(cards: [Card]) {
        self.cardsPeeking = cards
        self.isShowingPeek = true
    }

    func showDeckPositionRequest() {
        self.isShowingDeckPositionRequest = true
    }

    func hideDeckPositionRequest() {
        self.isShowingDeckPositionRequest = false
    }

    func toggleDeckPositionRequest(to isShowingRequest: Bool) {
        self.isShowingDeckPositionRequest = isShowingRequest
    }

    func setDeckPositionRequestArgs(_ args: DeckPositionRequestArgs) {
        self.deckPositionRequestArgs = args
    }

    func togglePlayerHandPositionRequest(to isShowingRequest: Bool) {
        self.isShowingPlayerHandPositionRequest = isShowingRequest
    }

    func setPlayerHandPositionRequestArgs(_ args: PlayerHandPositionRequestArgs) {
        self.playerHandPositionRequestArgs = args
    }

    func toggleCardTypeRequest(to isShowingRequest: Bool) {
        self.isShowingCardTypeRequest = isShowingRequest
    }

    func setCardTypeRequestArgs(_ args: CardTypeRequestArgs) {
        self.cardTypeRequestArgs = args
    }

    func advanceToNextPlayer() {
        guard let nextPlayer = nextPlayerGenerator?.getNextPlayer(gameRunner: self) else {
            return
        }

        onAdvanceNextPlayer()
        players.setCurrentPlayer(nextPlayer)
    }

    // Exploding kitten specific related methods

    var getAllCardTypes: [ExplodingKittensCardType] {
        ExplodingKittensUtils.getAllCardTypes()
    }

    func dispatchDeckPositionResponse(offsetFromTop: Int) {
        guard let args = deckPositionRequestArgs else {
            return
        }

        ActionDispatcher.runAction(
            DeckPositionResponseAction(
                card: args.card,
                player: args.player,
                offsetFromTop: offsetFromTop
            ),
            on: self
        )
    }

    func dispatchPlayerHandPositionResponse(playerHandPosition: Int) {
        guard let args = playerHandPositionRequestArgs else {
            return
        }

        ActionDispatcher.runAction(
            PlayerHandPositionResponseAction(target: args.target,
                                             player: args.player,
                                             playerHandPosition: playerHandPosition),
            on: self
        )
    }

    func dispatchCardTypeResponse(cardTypeRawValue: String) {
        guard let args = cardTypeRequestArgs else {
            return
        }

        ActionDispatcher.runAction(
            CardTypeResponseAction(target: args.target,
                                   player: args.player,
                                   cardTypeRawValue: cardTypeRawValue),
            on: self)
    }
}
