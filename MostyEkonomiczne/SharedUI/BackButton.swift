//
//  BackButton.swift
//  MostyEkonomiczne
//
//  Created by Patryk Jastrzębski on 25/02/2024.
//

import SwiftUI

struct BackButton: View {
    var size: CGFloat = 1
    var body: some View {
        Image(systemName: "chevron.backward")
            .font(.title2)
    }
}

#Preview {
    BackButton()
}
