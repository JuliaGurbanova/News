//
//  NewsApp.swift
//  News
//
//  Created by Julia Gurbanova on 07.10.2023.
//

import SwiftUI

@main
struct NewsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                SelectSomethingView()
            }
        }
    }
}
