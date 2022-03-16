//
//  CardView.swift
//  CardBox
//
//  Created by mactest on 13/03/2022.
//

import SwiftUI

struct CardView: View {
    @EnvironmentObject var gameRunnerViewModel: GameRunner
    let cardViewModel: CardViewModel
    var isFaceUp: Bool

    init(cardViewModel: CardViewModel) {
        self.cardViewModel = cardViewModel
        self.isFaceUp = cardViewModel.isFaceUp
    }


    
    func buildView() -> AnyView {
        if let card = cardViewModel.card {
            guard let imageName = cardViewModel.imageName else {
                return AnyView(
                    Rectangle()
                        .fill(Color.red)
                )
            }
            return AnyView(
                VStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(2.0, contentMode: .fill)
                        .frame(maxWidth: 100, maxHeight: 100)
                        .border(.black)
                        .padding(.top)
                    Text(card.name)
                        .fontWeight(.bold)
                    Text(card.cardDescription)
                        .font(.caption)
                    Spacer()
                }
                    .gesture(
                        DragGesture(minimumDistance: 0.0)
                            .onChanged { _ in
                                gameRunnerViewModel.cardPreview = card
                            }
                            .onEnded { _ in
                                gameRunnerViewModel.cardPreview = nil
                            }
                    )
            )
                
        } else {
            return AnyView(
                Text("No card in stack")
                    .fontWeight(.bold)
            )
        }
    }

    var body: some View {
        buildView()
            .padding()
            .aspectRatio(0.5, contentMode: .fill)
            .frame(width: 150, height: 250)
            .background(Color.white)
            .border(.black)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardViewModel: CardViewModel(card: Card(name: "Bomb")))
    }
}
