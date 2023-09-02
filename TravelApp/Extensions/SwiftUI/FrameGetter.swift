//
//  FrameGetter.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 17/06/2023.
//

import SwiftUI

/// It is a cumbersome, but necessary way to get the frame in SwiftUI with a simple modifier.
struct FrameGetter: ViewModifier {
  
    @Binding var frame: CGRect
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    // This avoids an infinite layout loop
                    if rect.integral != self.frame.integral {
                        Task {
                            await MainActor.run {
                                self.frame = rect
                            }
                        }
                    }
                return AnyView(EmptyView())
            })
    }
}

extension View {
    func frameGetter(_ frame: Binding<CGRect>) -> some View {
        modifier(FrameGetter(frame: frame))
    }
}
