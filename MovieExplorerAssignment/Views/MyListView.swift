//
//  MyListView.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//

import SwiftUI

struct MyListView: View {
    @EnvironmentObject var viewModel: MovieViewModel

        var body: some View {
            List {
                ForEach(viewModel.myList) { movie in
                    HStack(spacing: 12) {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath ?? "")")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 60, height: 90)
                        .cornerRadius(8)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(movie.title).font(.headline)
                            Text("⭐ \(movie.voteAverage, specifier: "%.1f")").font(.caption)
                        }
                    }.padding(.vertical, 6)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("My List")
        }
}
