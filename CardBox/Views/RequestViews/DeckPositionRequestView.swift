//
//  DeckPositionRequestView.swift
//  CardBox
//
//  Created by Stuart Long on 19/3/22.
//

import SwiftUI

struct DeckPositionRequestView: View {
    @EnvironmentObject var gameRunnerViewModel: GameRunner

    var body: some View {
        if gameRunnerViewModel.isShowingDeckPositionRequest {
            PositionRequestView(
                dispatchPositionResponse: gameRunnerViewModel.dispatchDeckPositionResponse,
                toggleShowPositionRequestView: gameRunnerViewModel.toggleDeckPositionRequest,
                size: gameRunnerViewModel.deck.count
            )
        }
    }
}

struct DeckPositionRequest_Previews: PreviewProvider {
    static var previews: some View {
        DeckPositionRequestView()
    }
}
