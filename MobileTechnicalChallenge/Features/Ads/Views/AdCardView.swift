import SwiftUI
import Kingfisher
import UIKit


// MARK: - AdCardView
struct AdCardView: View {
    let ad: Advertisement
    
    var body: some View {
        VStack(alignment: .center) {
            AdImageFormView(adId: ad.id,
                            photo: ad.photo,
                            price: ad.price)
            AdTitleView(title: ad.title,
                        location: ad.location)
        }
        .padding(.top, 10)
    }
}



// MARK: - AdImageFormView
struct AdImageFormView: View {
    let adId : String
    let photo: String
    let price: String
    
    let width: CGFloat = 180
    let height: CGFloat = 155
    
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: photo) {
                KFImage(url)
                    .placeholder {
                        Color.gray.opacity(0.2)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Color.gray.opacity(0.2)
                    .frame(width: width, height: height)
                    .cornerRadius(8)
            }
            
            ZStack {
                FavoriteHeart(adId: adId)
            }
            .padding([.top, .trailing], 10)
            .frame(width: width, height: height, alignment: .topTrailing)

            Text(price + " kr")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding([.bottom, .leading], 10)
        }
        .frame(width: width, height: height)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.6), lineWidth: 1))
                    
    }
}


// MARK: - AdTitleView
struct AdTitleView: View {
    let title: String
    let location: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            HStack {
                Image(systemName: "location.fill")
                    .font(.system(size: 10))
                    .foregroundColor(.blue)
                
                Text(location)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 5)
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)

        }
        .frame(width: 180, alignment: .leading)
    }
}



// MARK: - FavoriteHeart
struct FavoriteHeart: View {
    let adId: String
    @Environment(FavoritesStore.self) private var favorites
    @State private var isAnimating = false
    @State private var isPressed = false
    
    private var isFavorite: Bool { favorites.favoriteIDs.contains(adId) }
    private let impact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        Button(action: {
            guard !isPressed else { return }
            
            isPressed = true
            impact.impactOccurred()
            
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                favorites.toggle(adId)
                isAnimating = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isAnimating = false
                isPressed = false
            }
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .resizable()
                .scaledToFit()
                .foregroundColor(isFavorite ? .blue : .white)
                .frame(width: 20, height: 20)
                .scaleEffect(isAnimating ? 1.3 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isAnimating)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isPressed)
    }
}


#Preview {
    AdCardView(ad: Advertisement(
        id: "1",
        photo: "",
        price: "1 500",
        location: "Oslo",
        title: "Amazing apartment in the city center"
    ))
    .environment(FavoritesStore())
}

