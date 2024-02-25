//
//  RoleBadge.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import SwiftUI

// TODO: Add tap action - redirect to map

struct RoleBadge: View {
    let role: UserRole
    var body: some View {
        HStack(spacing: 4) {
            Text(role.icon)
            Text(role.name)
                .fontWeight(.semibold)
            Text(role.city)
                .fontWeight(.semibold)
        }
        .foregroundStyle(Colors.Foreground.secondary.color)
        .font(.subheadline)
        .padding(8)
        .background(Colors.Background.gray.color)
        .cornerRadius(20)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(Colors.Background.lightGray.color, lineWidth: 2)
        )
    }
}

#Preview {
    RoleBadge(role: .mock)
}
