//
//  EndTurnEvent.swift
//  CardBox
//
//  Created by mactest on 12/03/2022.
//

struct EndTurnEvent: GameEvent {
    func updateRunner(gameRunner: GameRunner) {
        gameRunner.onEndTurn()
    }
}
