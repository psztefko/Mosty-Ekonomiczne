//
//  UserProfileView.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import SwiftUI

struct UserProfileImageView: View {
    var size: CGFloat = 140
    var border: CGFloat = 8
    var url: String?
    
    @ViewBuilder
    var body: some View {
        if let url {
            ZStack {
                Circle()
                    .fill(.black)
                    .frame(width: size + border)
                CustomWebImage(url: url)
                    .frame(width: size)
                    .clipped(antialiased: true)
                    .clipShape(Circle())
            }
        }
    }
}

#Preview {
    UserProfileImageView()
}
