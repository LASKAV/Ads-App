

struct AdvertisementDTO: Decodable {
    let description: String
    let id: String
    let url: String
    let adType: String
    let location: String
    let type: String
    let price: PriceDTO
    let image: ImageDTO
    let score: Double
    let version: String
    let favourite: FavouriteDTO
    
}
