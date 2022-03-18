//
//  NonCurrentPlayerView.swift
//  CardBox
//
//  Created by Stuart Long on 19/3/22.
//

import SwiftUI

struct NonCurrentPlayerView: View {
    @EnvironmentObject var gameRunnerViewModel: GameRunner

    var body: some View {
        VStack {
            if let player3 = gameRunnerViewModel.players.getPlayerByIndexAfterCurrent(2) {
                PlayerView(player: player3)
                    .rotationEffect(.degrees(-180))
            }
            Spacer()
            HStack {
                if let player4 = gameRunnerViewModel.players.getPlayerByIndexAfterCurrent(3) {
                    PlayerView(player: player4)
                        .rotationEffect(.degrees(90))
                }
                Spacer()
                DeckView(deckViewModel: DeckViewModel(deck: gameRunnerViewModel.deck))
                DeckView(deckViewModel: DeckViewModel(deck: gameRunnerViewModel.gameplayArea))
                Spacer()
                if let player2 = gameRunnerViewModel.players.getPlayerByIndexAfterCurrent(1) {
                    PlayerView(player: player2)
                        .rotationEffect(.degrees(-90))
                }
            }
            Button {
                gameRunnerViewModel.nextPlayer()
            } label: {
                Text("Next")
                    .font(.title)
                    .frame(width: 70, height: 50)
                    .border(.black)
            }
            // TODO: Make error appear and fade out when button pressed and invalid combo
            Text("Invalid combination")
        }
    }
}

struct NonCurrentPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NonCurrentPlayerView()
    }
}
