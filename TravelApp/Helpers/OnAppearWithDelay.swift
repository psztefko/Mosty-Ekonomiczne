//
//  OnAppearWithDelay.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 17/06/2023.
//

import Foundation

import SwiftUI

private extension Constants {
    static let delay = 0.5
}

/// Workaround view modifier for focus state on TextField
struct OnAppearFocusedModifier: ViewModifier {
    let delay: Double
    let action: SimpleAction
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                withDelay(seconds: delay) {
                    action()
                }
            }
    }
}

extension View {
    func onAppearWithDelay(delay: Double = Constants.delay, action: @escaping SimpleAction) -> some View {
        modifier(OnAppearFocusedModifier(delay: delay, action: action))
    }
}

@MainActor func withDelay(seconds: Double, action: @escaping () -> Void) {
    Task {
        try await Task.sleep(nanoseconds: UInt64(seconds * Double(NSEC_PER_SEC)))
        action()
    }
}
