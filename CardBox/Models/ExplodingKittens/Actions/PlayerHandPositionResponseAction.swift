//
//  PlayerHandPositionResponseAction.swift
//  CardBox
//
//  Created by mactest on 18/03/2022.
//

struct PlayerHandPositionResponseAction: Action {
    let targetPlayer: Player
    let player: Player
    let index: Int

    func executeGameEvents(gameRunner: GameRunnerReadOnly) {
        guard let card = targetPlayer.hand.getCardByIndex(index) else {
            return
        }

        let events = [MoveCardPlayerToPlayerEvent(
            card: card,
            fromPlayer: targetPlayer,
            toPlayer: player
        )]

        gameRunner.executeGameEvents(events)
    }
}
