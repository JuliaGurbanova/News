//
//  ContentView.swift
//  News
//
//  Created by Julia Gurbanova on 07.10.2023.
//

import SwiftUI

struct ContentView: View {
    enum LoadState {
        case loading, success, failure
    }

    @State private var articles = [Article]()
    @State private var loadState = LoadState.loading
    @State private var searchText = ""

    var body: some View {
        Group {
            switch loadState {
            case .loading:
                VStack {
                    Text("Downloading...")
                    ProgressView()
                }
            case .success:
                List(filteredArticles, rowContent: ArticleRow.init)
            case .failure:
                VStack {
                    Text("Failed to download articles")

                    Button("Retry") {
                        loadState = .loading

                        Task {
                            try await Task.sleep(nanoseconds: 500_000_000)
                            await downloadArticles()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("News")
        .task(downloadArticles)
        .refreshable(action: downloadArticles)
        .searchable(text: $searchText)
    }

    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return articles
        } else {
            return articles.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    @Sendable func downloadArticles() async {
        do {
            let url = URL(string: "https://hws.dev/news")!
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            articles = try decoder.decode([Article].self, from: data).sorted()
            loadState = .success
        } catch {
            loadState = .failure
        }
    }
}

#Preview {
    ContentView()
}
