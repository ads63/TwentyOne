//
//  CardView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 27.12.2022.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let showBack: Bool

    @ViewBuilder
    var body: some View {
        if showBack {
            Image("card_back")
        } else {
            AsyncImage(url: URL(string: card.image)) {
                image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image("card_back")
            }
        }
    }
}

// struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
// }
