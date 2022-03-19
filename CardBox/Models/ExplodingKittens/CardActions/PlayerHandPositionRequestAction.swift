//
//  PlayerHandPositionRequestAction.swift
//  CardBox
//
//  Created by mactest on 18/03/2022.
//

struct PlayerHandPositionRequestAction: CardAction {
    func executeGameEvents(gameRunner: GameRunnerReadOnly, args: CardActionArgs) {
        let target = args.target
        let player = args.player

        if case .single(let targetPlayer) = target {
            gameRunner.executeGameEvents([
                PlayerHandPositionRequestEvent(targetPlayer: targetPlayer, player: player)
            ])
        }
    }
}
