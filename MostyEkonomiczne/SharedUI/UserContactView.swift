//
//  UserContactView.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import SwiftUI

// TODO: Add tap action - redirect to external app

struct UserContactView: View {
    let contact: [ContactMedia]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(contact) { contact in
                HStack(spacing: 4) {
                    if let image = contact.icon.name {
                        Image(image)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .scaledToFill()
                    }
                    Text(contact.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
        }
        .padding(.top, 24)
    }
}

#Preview {
    UserContactView(contact: [])
}
