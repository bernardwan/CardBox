//
//  PlayerHandPositionView.swift
//  CardBox
//
//  Created by mactest on 18/03/2022.
//

import SwiftUI

struct PlayerHandPositionRequestView: View {
    let gameRunner: GameRunner
    @State private var position: Int = 0

    var handCount: Int {
        gameRunner.playerHandPositionRequestArgs?.player.hand.count ?? 0
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if self.position > 0 {
                        self.position -= 1
                    }
                }) {
                    Text("-")
                }
                Text(position.description)
                Button(action: {
                    if self.position < handCount - 1 {
                        self.position += 1
                    }
                }) {
                    Text("+")
                }
            }
            Button(action: {
                gameRunner.dispatchPlayerHandPositionResponse(index: position)
                gameRunner.hidePlayerHandPositionRequest()
            }) {
                Text("Submit")
            }
        }
    }
}
