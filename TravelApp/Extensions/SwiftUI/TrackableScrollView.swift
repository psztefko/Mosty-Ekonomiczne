//
//  TrackableScrollView.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 17/06/2023.
//

import SwiftUI

struct TrackableScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = [0]
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

public struct TrackableScrollView<Content>: View where Content: View {
    let axes: Axis.Set
    let showIndicators: Bool
    @Binding var contentOffset: CGFloat
    let content: Content
    
    @State var contentFrame: CGRect = .zero
    
    init(_ axes: Axis.Set = .vertical,
         showIndicators: Bool = true,
         contentOffset: Binding<CGFloat>,
         @ViewBuilder content: () -> Content) {
        self.axes = axes
        self.showIndicators = showIndicators
        self._contentOffset = contentOffset
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { outsideProxy in
            ScrollView(self.axes, showsIndicators: self.showIndicators) {
                ZStack(alignment: self.axes == .vertical ? .top : .leading) {
                    GeometryReader { insideProxy in
                        Color.clear
                            .preference(key: TrackableScrollViewOffsetPreferenceKey.self,
                                        value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy,
                                                                            insideProxy: insideProxy)])
                    }
                    VStack {
                        self.content
                            .frameGetter($contentFrame)
                    }
                }
            }
            .onPreferenceChange(TrackableScrollViewOffsetPreferenceKey.self) { value in
                self.contentOffset = value[0]
            }
        }
        .frame(maxWidth: axes == .horizontal ? .infinity : contentFrame.width,
               maxHeight: axes == .vertical ? .infinity :  contentFrame.height,
               alignment: .center)
    }
    
    private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
        if axes == .vertical {
            return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
        } else {
            return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
        }
    }
}
