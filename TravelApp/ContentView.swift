//
//  ContentView.swift
//  SwiftUITemplate
//
//  Created by Patryk Jastrzębski on 01/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TestViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button("save") {
                Environment.saveConfiguration(configuration: .localConfig)
            }
        }
        .task {
            do {
                _ = try await viewModel.fetch()
            } catch {
                print(error)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class TestViewModel: BaseNetworking, ObservableObject {
    let httpClient = HttpClientImpl.shared
    func fetch() async throws -> EmptyData {
        
        let request = HttpRequest(url: getBaseUrlWithVersion(.blank, with: .home),
                                  method: .get)
        return try await perform(request)
    }
}
