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
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.ads) { ad in
                                AdRow(ad: ad)
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
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
            }
            
        }
        .task {
            await viewModel.fetchAds()

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
}


