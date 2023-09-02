//
//  IconCircleView.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 17/06/2023.
//

import SwiftUI

struct IconCircleView: View {
    let geometryEffectId = "baseAnimation"
    @Namespace private var animation
    let imageFrameSize: CGFloat
    var place: Place
    var body: some View {
        VStack {
            if place.emoji.isEmoji() {
                ZStack {
                    Circle()
                        .strokeBorder(.blue.opacity(0.5), lineWidth: 2, antialiased: true)
                        .frame(width: imageFrameSize, height: imageFrameSize, alignment: .center)
                    
                    Text(place.emoji.emoji())
                        .font(.system(size: imageFrameSize / 3))
                }
                .matchedGeometryEffect(id: geometryEffectId, in: animation)
            }
            Text(place.name)
                .foregroundColor(.blue.opacity(0.8))
                .font(.caption)
                .fontWeight(.semibold)
        }
        .frame(width: imageFrameSize, height: nil, alignment: .center)
        .animation(.default, value: place)
    }
}

struct IconCircleView_Previews: PreviewProvider {
    static var previews: some View {
        IconCircleView(imageFrameSize: 70, place: .mock)
    }
}
