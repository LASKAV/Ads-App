import Foundation

extension Advertisement {
    init(dto: AdvertisementDTO) {
        self.id = dto.id
        let basePhotoURL = "https://images.finncdn.no/dynamic/480x360c/"
        self.photo = basePhotoURL + (dto.image?.url ?? "")

        
        let priceValue = dto.price?.value ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        self.price = formatter.string(from: NSNumber(value: priceValue)) ?? "\(priceValue)"

        self.location = dto.location
        self.title = dto.description
    }
}
