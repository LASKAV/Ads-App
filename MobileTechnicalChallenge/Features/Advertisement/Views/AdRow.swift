import SwiftUI
import Kingfisher

struct AdRow: View {
    let ad: Advertisement
    
    
    var body: some View {
        VStack(alignment: .center) {
            AdImage(ad: ad)
            AdDiscription(ad: ad)
        }
        .padding(.top, 10)
    }
}

struct AdDiscription: View {
    let ad: Advertisement
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(ad.location)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(ad.title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)

        }
        .frame(width: 180, alignment: .leading)
    }
}

struct AdImage: View {
    let ad: Advertisement
    
    @State private var animateGradient = false
    private let impact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: ad.photo) {
                KFImage(url)
                    .placeholder {
                        Color.gray.opacity(0.2)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 155)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Color.gray.opacity(0.2)
                    .frame(width: 180, height: 155)
                    .cornerRadius(8)
            }
            
            ZStack {
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color.white)
        
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(Color.gray.opacity(0.2))
                    .frame(width: 16, height: 16)
            }
            .frame(width: 22, height: 22)
            .padding([.top, .trailing], 10)
            .frame(width: 180, height: 155, alignment: .topTrailing)
            .onTapGesture {
                impact.impactOccurred()
            }

            Text(ad.price + " kr")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding([.bottom, .leading], 10)
        }
        .frame(width: 180, height: 155)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray.opacity(0.6), lineWidth: 1))
                    
    }
}
