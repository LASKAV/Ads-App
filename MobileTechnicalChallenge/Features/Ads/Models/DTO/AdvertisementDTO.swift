import Foundation


struct AdvertisementDTO: Codable {
    let id: String
    let description: String
    let price: PriceDTO?
    let image: ImageDTO?
    let location: String
}
