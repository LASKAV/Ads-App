import SwiftUI
import Foundation

struct AdsListView: View {
    @State private var viewModel = AdsViewModel()
    @State private var showingFavorites = false
    @State private var isFavoritesButtonPressed = false
    @State private var isBreathing = false
    @Environment(FavoritesStore.self) private var favoritesStore
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var filteredAds: [Advertisement] {
        if showingFavorites {
            return viewModel.ads.filter { favoritesStore.isFavorite($0) }
        } else {
            return viewModel.ads
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading ads…")
                } else if let error = viewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(filteredAds) { ad in
                                AdCardView(ad: ad)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    TitleView(title: "JAKTAK")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        guard !isFavoritesButtonPressed else { return }
                        
                        isFavoritesButtonPressed = true
                        showingFavorites.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isFavoritesButtonPressed = false
                        }
                    } label: {
                        Image(systemName: showingFavorites ? "heart.fill" : "heart")
                            .foregroundColor(showingFavorites ? .blue : .white)
                            .scaleEffect(isBreathing ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isBreathing)
                    }
                    .disabled(isFavoritesButtonPressed)
                }
            }
            
        }
        .task {
            await viewModel.fetchAds()
        }
        .onChange(of: showingFavorites) { _, newValue in
            if newValue {
                isBreathing = true
            } else {
                isBreathing = false
            }
        }
    }
}

struct TitleView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 25, weight: .semibold))
            .foregroundStyle(Color.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .bold()
    }
}


#Preview {
    AdsListView()
        .environment(FavoritesStore())
}



