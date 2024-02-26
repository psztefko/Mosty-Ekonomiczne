//
//  ProfileScreen.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import SwiftUI

struct ProfileScreen: View {
    let user: UserProfile = .mock
    
    var body: some View {
        VStack(spacing: 0) {
            backgroundImage
            
            UserProfileImageView(url: user.profileImageUrl)
                .padding(.top, -90)
            
            userName
            
            userDescription
            
            RoleBadge(role: user.role)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 22)
                .padding(.leading, 16)
            
            UserContactView(contact: user.contact)
            
            Spacer()
        }
    }
    
    private var userName: some View {
        Text(user.name + " " + user.lastName)
            .fontWeight(.semibold)
            .font(.title2)
            .padding(.top, 22)
    }
    
    private var backgroundImage: some View {
        CustomWebImage(url: user.backgroundImageUrl, contentMode: .fill)
            .frame(height: 180)
            .ignoresSafeArea(.container)
    }
    
    @ViewBuilder
    private var userDescription: some View {
        if let description = user.description {
            Text(description)
                .font(.footnote)
                .foregroundStyle(Colors.Foreground.secondary.color)
                .padding(.top, 10)
                .padding(.horizontal, 16)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ProfileScreen()
        .preferredColorScheme(.dark)
}
