//
//  DeckPositionRequestView.swift
//  CardBox
//
//  Created by mactest on 16/03/2022.
//

import SwiftUI

struct DeckPositionRequestView: View {
    @State private var position: Int = 0
    @EnvironmentObject var gameRunnerViewModel: GameRunner

    var minusButton: some View {
        Button(action: {
            if self.position > 0 {
                self.position -= 1
            }
        }) {
            Text("-")
        }
    }

    var addButton: some View {
        Button(action: {
            if self.position < gameRunnerViewModel.deck.count - 1 {
                self.position += 1
            }
        }) {
            Text("+")
        }
    }

    var overlay: some View {
        Rectangle()
            .background(Color.black)
            .opacity(0.5)
            .allowsHitTesting(true)
    }

    var messageBox: some View {
        VStack {
            Text("Select new position to put card in deck")
            HStack {
                minusButton
                Text(position.description)
                addButton
            }
            Button(action: {
                gameRunnerViewModel.dispatchDeckPositionResponse(offsetFromTop: position)
                gameRunnerViewModel.hideDeckPositionRequest()
            }) {
                Text("Submit")
            }
        }
        .contentShape(Rectangle())
        .padding(10)
        .background(Color.white)
    }

    var body: some View {
        ZStack {
            overlay
            messageBox
        }
    }
}
