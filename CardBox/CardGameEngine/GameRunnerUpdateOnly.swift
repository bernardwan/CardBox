//
//  GameRunnerUpdateOnly.swift
//  CardBox
//
//  Created by mactest on 15/03/2022.
//

protocol GameRunnerUpdateOnly {
    var deck: CardCollection { get }
    var state: GameState { get }
    var players: PlayerCollection { get }
    var gameplayArea: CardCollection { get }

    func setup()
    func onStartTurn()
    func onEndTurn()
    func setGameState(gameState: GameState)

    func setCardsPeeking(cards: [Card])

    func showDeckPositionRequest()
    func hideDeckPositionRequest()
    func toggleDeckPositionRequest(to: Bool)
    func setDeckPositionRequestArgs(_ args: DeckPositionRequestArgs)

    func togglePlayerHandPositionRequest(to: Bool)
    func setPlayerHandPositionRequestArgs(_ args: PlayerHandPositionRequestArgs)

    // TODO: Abstract card types into CardGameEngine, instead of only existing in exploding kittens
    func toggleCardTypeRequest(to: Bool)
    func setCardTypeRequestArgs(_ args: CardTypeRequestArgs)

    func advanceToNextPlayer()
}
