//
//  DashboardScreen.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DashboardScreen: View {
    @StateObject var viewModel = DashboardViewModelImpl()
    @State var test = false
    var body: some View {
        VStack(spacing: 0) {
            
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        DashboardScreen()
    }
}
