//
//  MovieModel.swift
//  MovieExplorerAssignment
//
//  Created by Tejash Singh on 07/06/25.
//

struct Movie: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

struct CastResponse: Codable {
    let cast: [CastMember]
    let crew: [CrewMember]
}

struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}

struct CrewMember: Codable, Identifiable {
    let id: Int
    let name: String
    let job: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, job
        case profilePath = "profile_path"
    }
}

let fallbackNowPlayingJSON = """
{
  "results": [
    {
      "id": 950387,
      "title": "A Minecraft Movie",
      "overview": "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld...",
      "poster_path": "/iPPTGh2OXuIv6d7cwuoPkw8govp.jpg",
      "vote_average": 6.1
    },
    {
      "id": 324544,
      "title": "In the Lost Lands",
      "overview": "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands...",
      "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
      "vote_average": 5.9
    }
  ]
}
"""

let fallbackPopularJSON = """
{
  "results": [
    {
      "id": 324544,
      "title": "In the Lost Lands",
      "overview": "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands...",
      "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
      "vote_average": 6.4
    },
    {
      "id": 1045938,
      "title": "G20",
      "overview": "After the G20 Summit is overtaken by terrorists, President Danielle Sutton must bring all her statecraft and military experience...",
      "poster_path": "/tSee9gbGLfqwvjoWoCQgRZ4Sfky.jpg",
      "vote_average": 6.4
    }
  ]
}
"""

let fallbackTopRatedJSON = """
{
  "results": [
    {
      "id": 278,
      "title": "The Shawshank Redemption",
      "overview": "Imprisoned in the 1940s for the double murder of his wife and her lover, Andy Dufresne begins a new life at Shawshank prison...",
      "poster_path": "/9cqNxx0GxF0bflZmeSMuL5tnGzr.jpg",
      "vote_average": 8.7
    },
    {
      "id": 238,
      "title": "The Godfather",
      "overview": "Spanning the years 1945 to 1955, the chronicle of the fictional Italian-American Corleone crime family...",
      "poster_path": "/3bhkrj58Vtu7enYsRolD1fZdja1.jpg",
      "vote_average": 8.7
    }
  ]
}
"""

let fallbackUpcomingJSON = """
{
  "results": [
    {
      "id": 324544,
      "title": "In the Lost Lands",
      "overview": "A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands...",
      "poster_path": "/iHf6bXPghWB6gT8kFkL1zo00x6X.jpg",
      "vote_average": 6.3
    },
    {
      "id": 950387,
      "title": "A Minecraft Movie",
      "overview": "Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld...",
      "poster_path": "/yFHHfHcUgGAxziP1C3lLt0q2T4s.jpg",
      "vote_average": 6.1
    }
  ]
}
"""
