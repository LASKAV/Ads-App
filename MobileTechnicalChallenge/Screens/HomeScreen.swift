import SwiftUI

struct HomeScreen: View {
    var body: some View {
        AdsListView()
    }
}

#Preview {
    HomeScreen()
        .environment(FavoritesStore())
}



