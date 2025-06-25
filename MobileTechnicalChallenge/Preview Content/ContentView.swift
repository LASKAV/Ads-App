import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeScreen()
    }
}

#Preview {
    ContentView()
        .environment(FavoritesStore())
}
