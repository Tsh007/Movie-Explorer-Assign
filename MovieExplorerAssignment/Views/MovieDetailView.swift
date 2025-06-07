//
//  MovieDetailView.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var viewModel: MovieViewModel
        let movie: Movie

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)
                    .cornerRadius(15)

                    Text(movie.title).font(.title).bold()
                    Text("⭐ \(movie.voteAverage, specifier: "%.1f")")
                    Text(movie.overview).font(.body)

                    if let director = viewModel.director {
                        Text("🎬 Director: \(director.name)").font(.subheadline)
                    }

                    if !viewModel.cast.isEmpty {
                        Text("👥 Cast:").font(.headline)
                        ForEach(viewModel.cast.prefix(5)) { cast in
                            Text("\(cast.name) as \(cast.character)").font(.subheadline)
                        }
                    }

                    Button(action: {
                        viewModel.toggleMyList(movie: movie)
                    }) {
                        Label(viewModel.isInMyList(movie: movie) ? "Remove from My List" : "Add to My List", systemImage: "plus")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }

                    if !viewModel.similarMovies.isEmpty {
                        Text("🔁 Similar Movies").font(.headline).padding(.top)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.similarMovies) { similar in
                                    VStack(alignment: .leading) {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(similar.posterPath ?? "")")) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
                                        }
                                        .frame(width: 100, height: 150)
                                        .cornerRadius(8)
                                        Text(similar.title).font(.caption).lineLimit(1)
                                        Text("⭐ \(similar.voteAverage, specifier: "%.1f")").font(.caption2)
                                    }
                                    .frame(width: 100)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                viewModel.fetchMovieCredits(movieID: movie.id)
                viewModel.fetchSimilarMovies(movieID: movie.id)
            }
            .navigationTitle("Details")
        }
}
