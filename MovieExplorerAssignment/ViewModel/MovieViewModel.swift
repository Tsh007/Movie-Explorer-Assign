//
//  MovieViewModel.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//
import SwiftUI

class MovieViewModel: ObservableObject {
    @Published var nowPlaying: [Movie] = []
    @Published var popular: [Movie] = []
    @Published var topRated: [Movie] = []
    @Published var upcoming: [Movie] = []
    @Published var myList: [Movie] = []
    @Published var similarMovies: [Movie] = []
    @Published var cast: [CastMember] = []
    @Published var director: CrewMember?
    
    @Published var isLoading: Bool = false
    @Published var usedFallback: Bool = false


    let baseURL = "https://api.themoviedb.org/3"
    let apiKey = "35fd3412de0583993dfea02c169c1472"

    func fetchCategory(_ category: String, completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(baseURL)/movie/\(category)?api_key=\(apiKey)") else {
            print("Invalid URL")
            loadFallbackData(for: category, completion: completion)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API error: \(error.localizedDescription)")
                self.loadFallbackData(for: category, completion: completion)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("API error: Invalid status code")
                self.loadFallbackData(for: category, completion: completion)
                return
            }

            guard let data = data else {
                print("No data returned from \(category)")
                self.loadFallbackData(for: category, completion: completion)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                self.loadFallbackData(for: category, completion: completion)
            }
        }.resume()
    }

    func loadFallbackData(for category: String, completion: @escaping ([Movie]) -> Void) {
        let json: String
        switch category {
        case "now_playing": json = fallbackNowPlayingJSON
        case "popular": json = fallbackPopularJSON
        case "top_rated": json = fallbackTopRatedJSON
        case "upcoming": json = fallbackUpcomingJSON
        default: return
        }
        self.usedFallback = true

        if let data = json.data(using: .utf8) {
            do {
                let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("Fallback decoding error: \(error.localizedDescription)")
            }
        }
    }

    func loadAll() {
            isLoading = true
            usedFallback = false
            let group = DispatchGroup()

            for (category, setter) in [("now_playing", { self.nowPlaying = $0 }),
                                        ("popular", { self.popular = $0 }),
                                        ("top_rated", { self.topRated = $0 }),
                                        ("upcoming", { self.upcoming = $0 })] {
                group.enter()
                fetchCategory(category) {
                    setter($0)
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self.isLoading = false
            }
    }

    func fetchMovieCredits(movieID: Int) {
        guard let url = URL(string: "\(baseURL)/movie/\(movieID)/credits?api_key=\(apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Credits error: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            if let decoded = try? JSONDecoder().decode(CastResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.cast = decoded.cast
                    self.director = decoded.crew.first { $0.job == "Director" }
                }
            }
        }.resume()
    }

    func fetchSimilarMovies(movieID: Int) {
        guard let url = URL(string: "\(baseURL)/movie/\(movieID)/similar?api_key=\(apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Similar movies error: \(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            if let decoded = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.similarMovies = decoded.results
                }
            }
        }.resume()
    }

    func toggleMyList(movie: Movie) {
        if myList.contains(movie) {
            myList.removeAll { $0 == movie }
        } else {
            myList.append(movie)
        }
    }

    func isInMyList(movie: Movie) -> Bool {
        return myList.contains(movie)
    }
}
