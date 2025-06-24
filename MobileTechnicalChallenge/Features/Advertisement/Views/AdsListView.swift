import SwiftUI


struct AdsListView: View {
    @State private var viewModel = AdsViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

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
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.ads) { ad in
                                AdRow(ad: ad)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Announcements")
        }
        .task {
            await viewModel.fetchAds()
        }
    }
}

#Preview {
    AdsListView()
}
