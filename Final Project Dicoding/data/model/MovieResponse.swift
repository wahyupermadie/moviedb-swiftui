//
//  MovieResponse.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 16/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import SwiftUI

public struct MoviesResponse: Codable {
    public let page: Int?
    public let totalResults: Int?
    public let totalPages: Int?
    public let results: [Movie]?
    
    public enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
    
    public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            page = try values.decodeIfPresent(Int.self, forKey: .page)
            results = try values.decodeIfPresent([Movie].self, forKey: .results)
            totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
            totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
    }
}

public struct Movie : Codable, Identifiable {

        public let adult : Bool?
        public let backdropPath : String?
        public let genreIds : [Int]?
        public let id : Int
        public let originalLanguage : String?
        public let originalTitle : String?
        public let overview : String?
        public let popularity : Float?
        public let posterPath : String?
        public let releaseDate : String?
        public let title : String?
        public let video : Bool?
        public let voteAverage : Float?
        public let voteCount : Int?
    
    private enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id
        case adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
