import Foundation


struct Advertisement: Identifiable {
    let id = UUID()
    
    let photo: String
    let price: String
    let location: String
    let title: String
}

extension Advertisement {
    init(dto: AdvertisementDTO) {
        let baseURL = "https://images.finncdn.no/dynamic/480x360c/"
        self.photo = baseURL + dto.image.url

        let priceValue = Int(dto.price?.value ?? 0)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        self.price = formatter.string(from: NSNumber(value: priceValue)) ?? "\(priceValue)"

        self.location = dto.location
        self.title = dto.description
    }
}

extension Advertisement {
    var imageURL: URL? {
        URL(string: photo)
    }
}

