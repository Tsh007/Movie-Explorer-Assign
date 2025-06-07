//
//  HomeView.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//

import SwiftUI
struct HomeView: View {
    @EnvironmentObject var viewModel: MovieViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading movies...").padding()
            } else {
                if viewModel.usedFallback {
                    Text("⚠️ Showing fallback data due to network issue.")
                        .foregroundColor(.orange)
                        .font(.subheadline)
                        .padding(.bottom, 8)
                }
                ScrollView {
                    VStack(spacing: 32) {
                        MovieRow(title: "🎬 Now Playing", movies: viewModel.nowPlaying)
                        MovieRow(title: "🌟 Popular", movies: viewModel.popular)
                        MovieRow(title: "🏆 Top Rated", movies: viewModel.topRated)
                        MovieRow(title: "⏳ Upcoming", movies: viewModel.upcoming)
                    }.padding(.top)
                }
            }
        }
        .navigationTitle("Movie Explorer")
    }
}
