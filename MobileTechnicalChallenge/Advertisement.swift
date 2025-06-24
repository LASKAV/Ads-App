import Foundation


struct Advertisement: Identifiable {
    let id = UUID()
    
    let photo: String
    let price: String
    let location: String
    let title: String
}

