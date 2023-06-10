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
//            Text(Strings.App.title)
            Text(Environment.configuration.serverUrlHost)
        }
        .task {
            do {
                let a = try await viewModel.fetch()
                print(a)
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
    func fetch() async throws -> Responseing {
        
        let request = HttpRequest(url: getBaseUrlWithVersion(.blank, with: .home),
                                  method: .get)
        return try await perform(request)
//        let response: EmptyData = try await httpClient.perform(httpRequest: request)
//        return response
    }
}
