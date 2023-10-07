//
//  ReadingView.swift
//  News
//
//  Created by Julia Gurbanova on 07.10.2023.
//

import SwiftUI

struct ReadingView: View {
    @Environment(\.openURL) var openURL
    let article: Article

    var body: some View {
        ScrollView {
            AsyncImage(url: article.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Image(systemName: "newspaper")
                }
            }

            VStack(alignment: .leading, spacing: 20) {
                Text(article.title)
                    .font(.title)

                Text(article.description)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Divider()

                VStack(alignment: .leading) {
                    Text(article.author)
                        .font(.headline.weight(.heavy))

                    Text(article.date.formatted(date: .abbreviated, time: .standard))
                        .font(.headline)
                }

                Text(article.text)
            }
            .padding(.horizontal)
        }
        .navigationTitle(article.section)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                openURL(article.url)
            } label: {
                Label("Open in your web browser", systemImage: "safari")
            }
        }
    }
}

#Preview {
    NavigationView {
        ReadingView(article: .example)
    }
}
