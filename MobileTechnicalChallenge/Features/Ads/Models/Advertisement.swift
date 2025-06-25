import Foundation


struct Advertisement: Identifiable {
    let id: String
    
    let photo: String
    let price: String
    let location: String
    let title: String
}

extension Advertisement {
    var imageURL: URL? {
        URL(string: photo)
    }
}


