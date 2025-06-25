import SwiftUI

@main
struct MobileTechnicalChallengeApp: App {
    
    private var favoritesStore = FavoritesStore()
    
    var body: some Scene {
        WindowGroup {
            AdsListView()
                .environment(favoritesStore)
        }
    }
}

#Preview {
    AdsListView()
        .environment(FavoritesStore())
}

