//
//  ImageLoader.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import SwiftUI
import Combine

@MainActor
class ImageLoader: ObservableObject {

    @Published var image: UIImage?

    func load(from url: URL) async {

        let request = URLRequest(url: url)

        // Cache
        if let cached = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cached.data) {

            self.image = cachedImage
            return
        }

        do {

            let (data, response) = try await URLSession.shared.data(for: request)

            URLCache.shared.storeCachedResponse(
                CachedURLResponse(response: response, data: data),
                for: request
            )

            self.image = UIImage(data: data)

        } catch {

            print(error)
        }
    }
}
