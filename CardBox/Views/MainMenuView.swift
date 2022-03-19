//
//  MainMenu.swift
//  CardBox
//
//  Created by Bernard Wan on 14/3/22.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("CardBox")
                    .font(.system(size: 50))
                Spacer()
                playOfflineButton
                hostGameButton
                joinButton
                Spacer()
            }
        }
    }

    var playOfflineButton: some View {
        Button {
            appState.page = .game
        } label: {
            Text("Play Offline")
                .font(.title)
                .frame(width: 400, height: 100)
                .border(Color.black)
                .foregroundColor(Color.orange)
                .background(Color.blue)
        }
    }

    var hostGameButton: some View {
        Button {
        } label: {
            Text("Host Game")
                .font(.title)
                .frame(width: 400, height: 100)
                .border(Color.black)
                .foregroundColor(Color.orange)
                .background(Color.blue)
        }
    }

    var joinButton: some View {
        Button {
        } label: {
            Text("Join Game")
                .font(.title)
                .frame(width: 400, height: 100)
                .border(Color.black)
                .foregroundColor(Color.orange)
                .background(Color.blue)
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        Text("stub")
    }
}
