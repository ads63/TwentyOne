//
//  CardsView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 27.12.2022.
//

import SwiftUI

struct CardsView: View {
    @ObservedObject var player: Player
    
    var body: some View {
        ZStack {
            ForEach(0 ..< player.cards.count, id: \.self) { index in
                CardView(card: player.cards[index], showBack: player.showBack)
                    .stacked(at: index, in: player.cards.count)
            }
        }
    }
}

extension CardView {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(1 + position - total / 2)
        return self.offset(x: offset * 25, y: 0)
    }
}

// struct CardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardsView()
//    }
// }
