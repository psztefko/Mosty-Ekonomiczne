//
//  DefaultSpringAnimation.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import Foundation
import SwiftUI

struct Constants {
    static let defaultSpringAnimation: Animation = .interactiveSpring(response: 0.5, dampingFraction: 0.7)
    /// Default corner radius is 10
    static let defaultCornerRadius: CGFloat = 10
    static let defaultTrailingPaddingInDescriptions: CGFloat = 18
    static let maxProductListViewIndex: Int = 4
}

extension Animation {
    static let defaultSpring = Constants.defaultSpringAnimation
}
