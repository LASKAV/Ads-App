import SwiftUI

struct AdsListView: View {
    @StateObject private var viewModel = AdsViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading ads…")
                } else if let error = viewModel.errorMessage {
                    Text("⚠️ \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.ads) { ad in
                        AdRow(ad: ad)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Announcements")
        }
        .task {
            await viewModel.fetchAds()
        }
    }
}
