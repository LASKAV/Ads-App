import Observation
import SwiftUI


@Observable
final class FavoritesStore {
    @ObservationIgnored
    private let key = "FavoriteIDs"
    
    private var _favoriteIDs: Set<String> = []

    init() {
        let stringIDs = UserDefaults.standard.stringArray(forKey: key) ?? []
        _favoriteIDs = Set(stringIDs)
    }
    
    var favoriteIDs: Set<String> {
        get {
            access(keyPath: \.favoriteIDs)
            return _favoriteIDs
        }
        set {
            withMutation(keyPath: \.favoriteIDs) {
                _favoriteIDs = newValue

                let stringIDs = Array(newValue)
                UserDefaults.standard.set(stringIDs, forKey: key)
            }
        }
    }

    func isFavorite(_ ad: Advertisement) -> Bool {
        favoriteIDs.contains(ad.id)
    }

    func toggle(_ adId: String) {
        var current = favoriteIDs

        if current.contains(adId) {
            current.remove(adId)
        } else {
            current.insert(adId)
        }

        favoriteIDs = current
    }
}
