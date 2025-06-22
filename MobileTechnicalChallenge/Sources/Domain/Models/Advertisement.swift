import Foundation


struct Advertisement: Identifiable {
    let id = UUID()
    
    let photo: String
    let price: String
    let location: String
    let title: String
}


// For each ad we want to see at least the following information:
// ● Photo
// ● Price
// ● Location
// ● Title
