//
//  ContentView.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieViewModel()

        var body: some View {
            TabView {
                NavigationView {
                    HomeView()
                }.tabItem {
                    Label("Home", systemImage: "house")
                }

                NavigationView {
                    MyListView()
                }.tabItem {
                    Label("My List", systemImage: "star")
                }
            }
            .environmentObject(viewModel)
            .onAppear { viewModel.loadAll() }
        }
}

#Preview {
    ContentView()
}
