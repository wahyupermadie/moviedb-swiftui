//
//  Helper.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 17/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    return jsonDecoder
}()

var fakes: [Movie] {
    return [
        fake,
        fake,
        fake,
        fake
    ]
}

var fake: Movie {
    Movie(adult: false, backdropPath: "", genreIds: [2,3,4], id: 45, originalLanguage: "hahaha", originalTitle: "Wahyu Permado", overview: "hello bro", popularity: 45, posterPath: "hahaha", releaseDate: "212121", title: "Wahyu permadi", video: false, voteAverage: 4.6, voteCount: 1000)
}

extension String {
    func getPosterPathUrl() -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(self)")!
    }
}
