//
//  CustomButton.swift
//  TwentyOne
//
//  Created by Алексей Шинкарев on 29.12.2022.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(CustomButtonStyle(bgColor: .black.opacity(0.5), fgColor: .white))
    }
}

struct CustomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    var bgColor: Color
    var fgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(bgColor)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .foregroundColor(isEnabled ? fgColor : fgColor.opacity(0.3))
            .animation(.spring(), value: 0.5)
    }
}

// struct CustomButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomButton()
//    }
// }
