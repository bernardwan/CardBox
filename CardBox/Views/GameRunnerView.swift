//
//  GameRunnerView.swift
//  CardBox
//
//  Created by mactest on 12/03/2022.
//

import SwiftUI

struct GameRunnerView: View {

    @StateObject var gameRunnerViewModel = ExplodingKittensGameRunnerInitialiser.getAndSetupGameRunnerInstance()

    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                if let playerThreeViewModel = gameRunnerViewModel.getPlayerViewModelAfterCurrent(2) {
                    PlayerView(playerViewModel: playerThreeViewModel)
                        .rotationEffect(.degrees(-180))

                }
                Spacer()
                HStack {
                    if let playerFourViewModel = gameRunnerViewModel.players.getPlayerViewModelAfterCurrent(3) {
                        PlayerView(playerViewModel: playerFourViewModel)
                            .rotationEffect(.degrees(90))
                    }
                    Spacer()
                    decks
                    playDeck
                    Spacer()
                    if let playerTwoViewModel = gameRunnerViewModel.players.getPlayerViewModelAfterCurrent(1) {
                        PlayerView(playerViewModel: playerTwoViewModel)
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
                Spacer()

                if let currentPlayerViewModel = gameRunnerViewModel.players.getCurrentPlayerViewModel() {
                    PlayerView(playerViewModel: currentPlayerViewModel)
                }

            }
            if let cardPreview = gameRunnerViewModel.cardPreview {
                CardView(cardViewModel: CardViewModel(card: cardPreview, isFaceUp: true))
            }
        }.environmentObject(gameRunnerViewModel)
    }

    var decks: some View {
        DeckView(deckViewModel: DeckViewModel(deck: gameRunnerViewModel.deck))
    }

    var playDeck: some View {
        DeckView(deckViewModel: DeckViewModel(deck: gameRunnerViewModel.gameplayArea))
    }
}
