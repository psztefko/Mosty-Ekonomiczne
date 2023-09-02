//
//  AppDivider.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 02/09/2023.
//

import SwiftUI

struct AppDivider: View {
    
    var showingError = false
    var leadingPadding: CGFloat = 0
    
    init(showingError: Bool = false, leadingPadding: CGFloat = 0) {
        self.showingError = showingError
        self.leadingPadding = leadingPadding
    }
    
    init(leadingPadding: CGFloat = 0) {
        self.showingError = false
        self.leadingPadding = leadingPadding
    }
    
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 1)
            .padding(.leading, leadingPadding)
            .foregroundColor(showingError ? .red : Colors.Background.secondary.color)
    }
}

struct AppDivider_Previews: PreviewProvider {
    static var previews: some View {
        AppDivider()
    }
}
