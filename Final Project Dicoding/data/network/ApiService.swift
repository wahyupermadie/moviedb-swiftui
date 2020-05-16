//
//  ApiService.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 16/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

protocol MoviesRepository {
    func fetchPopularMovies(responseData: @escaping (_ movieResponse: MovieResponse) -> Void, errorHandler: @escaping( _ errorState: Bool) -> Void)
}

class IMoviesRepository : MoviesRepository {
    var urlComponents = URLComponents(string: "\(MovieDbUrl.BASE_URL)/\(MovieDbUrl.POPULAR_MOVIES))")
    var queryItems = [URLQueryItem(name: "api_key", value: MovieDbUrl.API_KEY)]
    
    private let urlSession: URLSession = URLSession.shared
    
    func fetchPopularMovies(responseData: @escaping (MovieResponse) -> Void, errorHandler: @escaping (Bool) -> Void) {
        urlComponents!.queryItems = queryItems
        urlSession.dataTask(with: urlComponents!.url!) { (data, response, error) in
            if error != nil {
                errorHandler(true)
                return
            }
            
            do {
                let movie = try jsonDecoder.decode(MovieResponse.self, from: data!)
                DispatchQueue.main.async {
                    responseData(movie)
                }
            } catch {
                errorHandler(true)
            }
        }.resume()
    }
}

struct MovieDbUrl {
    static let API_KEY = "01c5d0d1ff15325934327ab3965e26f6"
    static let BASE_URL = "https://api.themoviedb.org/3/movie/"
    static let POPULAR_MOVIES = "popular"
}


