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

    func showDeckPositionRequest()
    func hideDeckPositionRequest()
    func setDeckPositionRequestArgs(_ args: DeckPositionRequestArgs)
    func advanceToNextPlayer()

    func showPlayerHandPositionRequest()
    func hidePlayerHandPositionRequest()
    func setPlayerHandPositionRequestArgs(_ args: PlayerHandPositionRequestArgs)
}
