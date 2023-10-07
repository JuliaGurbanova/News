//
//  SelectSomethingView.swift
//  News
//
//  Created by Julia Gurbanova on 07.10.2023.
//

import SwiftUI

struct SelectSomethingView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "newspaper")
                .font(.largeTitle)
                .foregroundColor(.accentColor)

            Text("Welcome to News!")
                .font(.title)

            Text("Please select an item to view.")

        }
    }
}

#Preview {
    SelectSomethingView()
}
