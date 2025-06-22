import Foundation


// So for example if you get
// “2017/9/vertical-5/30/5/105/424/ _1263219766.jpg"
// the final URL will be:
// https://images.finncdn.no/dynamic/480x360c/2017/9/vertical-5/30/5/105/424/_1263219766.jpg

// For each ad we want to see at least the following information:
// ● Photo
// ● Price
// ● Location
// ● Title


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
