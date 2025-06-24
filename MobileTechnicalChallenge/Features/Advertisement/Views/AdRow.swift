import SwiftUI
import Kingfisher


// MARK: AdRow
struct AdRow: View {
    let ad: Advertisement
    
    var body: some View {
        VStack(alignment: .center) {
            AdImageFormView(photo: ad.photo, price: ad.price)
            AdTitleView(title: ad.title, location: ad.location)
        }
        .padding(.top, 10)
    }
}



// MARK: AdImageFormView
struct AdImageFormView: View {
    let photo: String
    let price: String
    
    let width: CGFloat = 180
    let height: CGFloat = 155
    
    @State private var animateGradient = false
    private let impact = UIImpactFeedbackGenerator(style: .medium)
    
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
            .frame(width: width, height: height, alignment: .topTrailing)
            .onTapGesture {
                impact.impactOccurred()
            }

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



// MARK: AdTitleView
struct AdTitleView: View {
    let title: String
    let location: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(location)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)

        }
        .frame(width: 180, alignment: .leading)
    }
}
