//
//  ErrorView.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 29.12.2022.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var game: Game
    
    var body: some View {
        VStack {
            Text(game.error?.errorDescription ?? "Unknown error")
                .foregroundColor(.red)
            CustomButton(title: "New game") {
                game.newGame()
            }
            .padding(32)
        }
    }
}

// struct ErrorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ErrorView()
//    }
// }

