//
//  CustomWebImage.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 11/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomWebImage: View {
    @StateObject var viewModel: CustomWebImageViewModel
    @Binding var imageFailed: Bool
    @Binding var url: String
    var imageFailedName = Asset.Icons.noPhotography.name
    var placeHolderImage = ""
    var contentMode: ContentMode = .fit
    var size: CGFloat
    
    init(imageFailed: Binding<Bool>,
         url: String,
         imageFailedName: String = Asset.Icons.noPhotography.name,
         placeHolderImage: String = "",
         contentMode: ContentMode = .fit) {
        self._imageFailed = imageFailed
        self._url = Binding<String>.constant(url)
        self.imageFailedName = imageFailedName
        self.placeHolderImage = placeHolderImage
        self.contentMode = contentMode
        self.size = .infinity
        _viewModel = StateObject(wrappedValue: CustomWebImageViewModel())
    }
    
    init(url: String,
         imageFailedName: String = Asset.Icons.noPhotography.name,
         placeHolderImage: String = "",
         contentMode: ContentMode = .fit,
         size: CGFloat) {
        self._imageFailed = .constant(false)
        self._url = Binding<String>.constant(url)
        self.imageFailedName = imageFailedName
        self.placeHolderImage = placeHolderImage
        self.contentMode = contentMode
        self.size = size
        _viewModel = StateObject(wrappedValue: CustomWebImageViewModel())
    }
    
    init(url: String,
         imageFailedName: String = Asset.Icons.noPhotography.name,
         placeHolderImage: String = "",
         contentMode: ContentMode = .fit) {
        self._imageFailed = .constant(false)
        self._url = Binding<String>.constant(url)
        self.imageFailedName = imageFailedName
        self.placeHolderImage = placeHolderImage
        self.contentMode = contentMode
        self.size = .infinity
        _viewModel = StateObject(wrappedValue: CustomWebImageViewModel())
    }
    
    var body: some View {
        VStack {
            if viewModel.imageFailed {
                Image(imageFailedName)
                    .resizable()
                    .scaledToFit()
            } else {
                WebImage(url: URL(string: url.isEmpty ? UUID().uuidString : url), options: .refreshCached)
                    .placeholder(Image(placeHolderImage))
                    .onFailure(perform: { _ in
                        viewModel.imageFailed = true
                    })
                    .resizable()
                    .frame(maxWidth: size, maxHeight: size)
                    .aspectRatio(contentMode: contentMode)
                    .onChange(of: viewModel.imageFailed) { newValue in
                        imageFailed = newValue
                    }
            }
        }
        .onChange(of: url) { _ in
            viewModel.imageFailed = false
            imageFailed = false
        }
    }
}

final class CustomWebImageViewModel: ObservableObject {
    @Published var imageFailed = false
}
