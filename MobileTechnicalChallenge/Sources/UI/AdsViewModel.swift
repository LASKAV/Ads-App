import Foundation


@MainActor
class AdsViewModel: ObservableObject {
    @Published var ads: [Advertisement] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let client = DefaultAPIClient()
    private let endpoint = AdsEndpoint()

    func fetchAds() async {
        isLoading = true
        errorMessage = nil

        do {
            
            let response = try await client.request(endpoint, as: AdsItemsResponseDTO.self)
            let ads = response.items.map { Advertisement(dto: $0) }
            self.ads = ads

            Logger.log("✅ Ads \(ads.count) received", level: .info)
             
        } catch {
            errorMessage = error.localizedDescription
            Logger.log("Error loading adsReceived ads: \(error.localizedDescription)", level: .error)
        }

        isLoading = false
    }

}


