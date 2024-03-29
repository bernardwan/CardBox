//
//  NonCurrentPlayerView.swift
//  CardBox
//
//  Created by Stuart Long on 19/3/22.
//

import SwiftUI

struct NonCurrentPlayerView: View {
    @EnvironmentObject private var gameRunnerViewModel: GameRunner
    @Binding var error: Bool
    var currentPlayerViewModel: PlayerViewModel
    @Binding var selectedPlayerViewModel: PlayerViewModel?

    var body: some View {
        VStack {
            if let player3 = gameRunnerViewModel.players.getPlayerByIndexAfterCurrent(2) {
                PlayerView(playerViewModel: PlayerViewModel(player: player3),
                           error: $error,
                           selectedPlayerViewModel: $selectedPlayerViewModel)
                    .rotationEffect(.degrees(-180))

            }
            Spacer()
            middlePart
            GameActionsView(error: $error,
                            currentPlayerViewModel: currentPlayerViewModel,
                            selectedPlayerViewModel: $selectedPlayerViewModel)
        }
    }

    var middlePart: some View {
        HStack {
            if let player4 = gameRunnerViewModel.players.getPlayerByIndexAfterCurrent(3) {
                PlayerView(playerViewModel: PlayerViewModel(player: player4),
                           error: $error,
                           selectedPlayerViewModel: $selectedPlayerViewModel)
                    .rotationEffect(.degrees(90))
            }
            Spacer()
            DeckView(deckViewModel: DeckViewModel(deck: gameRunnerViewModel.deck), isFaceUp: false)
            DeckView(deckViewModel: DeckViewModel(deck: gameRunnerViewModel.gameplayArea), isFaceUp: true)
            Spacer()
            if let player2 = gameRunnerViewModel.players.getPlayerByIndexAfterCurrent(1) {
                PlayerView(playerViewModel: PlayerViewModel(player: player2),
                           error: $error,
                           selectedPlayerViewModel: $selectedPlayerViewModel)
                    .rotationEffect(.degrees(-90))
            }
        }
    }
}

struct NonCurrentPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NonCurrentPlayerView(error: .constant(false),
                             currentPlayerViewModel: PlayerViewModel(player: Player(name: "test")),
                             selectedPlayerViewModel: .constant(nil))
    }
}
