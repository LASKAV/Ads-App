import Foundation
import Kingfisher
import SwiftUI


@MainActor
@Observable
class AdsViewModel {
    var ads: [Advertisement] = []
    var isLoading: Bool = false
    var errorMessage: String?

    private let client = DefaultAPIClient()
    private let endpoint = GetAds()

    func fetchAds() async {
        isLoading = true
        errorMessage = nil

        do {
            
            let response = try await client.request(endpoint, as: AdsItemsResponseDTO.self)
            
            let ads = response.items.map { Advertisement(dto: $0) }
            self.ads = ads
            
            prefetchImages(urls: ads.compactMap { URL(string: $0.photo) })
            
            Logger.log("✅ Ads \(ads.count) received", level: .info)
             
        } catch {
            errorMessage = error.localizedDescription
            Logger.log("Error loading adsReceived ads: \(error.localizedDescription)", level: .error)
        }

        isLoading = false
    }
    private func prefetchImages(urls: [URL]) {
            let prefetcher = ImagePrefetcher(urls: urls)
            prefetcher.start()
        }
}
