//
//  CloseButton.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 18/06/2023.
//

import SwiftUI

struct CloseButton: View {
    let action: SimpleAction

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(width: 11, height: 11, alignment: .center)
                    .padding(11)
                    .background(.quaternary)
                    .clipShape(Circle())
            }
        }
    }
}
struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton { }
    }
}
