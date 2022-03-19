//
//  PlayerHandPositionRequestEvent.swift
//  CardBox
//
//  Created by mactest on 18/03/2022.
//

struct PlayerHandPositionRequestArgs {
    let targetPlayer: Player
    let player: Player
}

struct PlayerHandPositionRequestEvent: GameEvent {
    let targetPlayer: Player
    let player: Player

    func updateRunner(gameRunner: GameRunnerUpdateOnly) {
        let args = PlayerHandPositionRequestArgs(
            targetPlayer: targetPlayer,
            player: player
        )
        gameRunner.setPlayerHandPositionRequestArgs(args)
        gameRunner.showPlayerHandPositionRequest()
    }
}
