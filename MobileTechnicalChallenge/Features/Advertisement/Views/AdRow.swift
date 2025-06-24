import SwiftUI
import Kingfisher

struct AdRow: View {
    let ad: Advertisement

    var body: some View {
        VStack(alignment: .center) {
            AdImage(ad: ad)
            AdDiscription(ad: ad)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
        .onTapGesture {
            let impact = UIImpactFeedbackGenerator(style: .medium)
            impact.impactOccurred()
        }
    }
}

struct AdDiscription: View {
    let ad: Advertisement
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(ad.title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1)

            Text(ad.location)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 160, alignment: .leading)
    }
}

struct AdImage: View {
    let ad: Advertisement
    
    @State private var animateGradient = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: ad.photo) {
                KFImage(url)
                    .placeholder {
                        Color.gray.opacity(0.2)
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 120)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Color.gray.opacity(0.2)
                    .frame(width: 170, height: 120)
                    .cornerRadius(8)
            }

            Text(ad.price + " kr")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.5))
                .cornerRadius(4)
                .padding(6)
        }
        .frame(width: 170, height: 120)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.5), lineWidth: 1))
                    
    }
}

struct AdPreviewView: View {
    let ad: Advertisement

    var body: some View {
        VStack(spacing: 16) {
            if let url = URL(string: ad.photo) {
                KFImage(url)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
            }

            Text(ad.title)
                .font(.headline)

            Text(ad.price + " kr")
                .font(.title2)
                .foregroundColor(.blue)

            Text("Location: \(ad.location)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.4), .medium])
        .presentationDragIndicator(.visible)
    }
}
