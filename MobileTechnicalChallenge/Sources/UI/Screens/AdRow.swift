import SwiftUI

struct AdRow: View {
    let ad: Advertisement

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: ad.photo)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 75)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 75)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .frame(width: 100, height: 75)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(ad.title)
                    .font(.headline)

                Text(ad.price)
                    .font(.subheadline)
                    .foregroundColor(.green)

                Text(ad.location)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}
