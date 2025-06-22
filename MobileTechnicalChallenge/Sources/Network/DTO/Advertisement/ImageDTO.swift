import Foundation


struct ImageDTO: Decodable {
    let url: String
    let height: Int
    let width: Int
    let type: String
    let scalable: Bool
}

