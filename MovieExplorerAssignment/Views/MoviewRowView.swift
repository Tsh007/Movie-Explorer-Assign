//
//  MoviewRowView.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//

import SwiftUI

struct MovieRow: View {
    let title: String
        let movies: [Movie]

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(title).font(.title3.bold()).padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                VStack(alignment: .leading, spacing: 4) {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.3))
                                    }
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(10)

                                    Text(movie.title).font(.footnote.bold()).lineLimit(1)
                                    Text("⭐ \(movie.voteAverage, specifier: "%.1f")").font(.caption)
                                }.frame(width: 120)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        }
}
