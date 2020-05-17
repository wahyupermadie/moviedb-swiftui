//
//  ApiService.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 16/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import UIKit

protocol IMoviesRepository {
    func fetchPopularMovies(responseData: @escaping (_ movieResponse: MoviesResponse) -> Void, errorHandler: @escaping( _ errorState: Bool) -> Void)
    func fetchImage(from imageUrl: URL, imageData: @escaping (UIImage) ->Void,
                    errorHandler: @escaping( _ errorState: Bool) -> Void)
}

class MoviesRepository : IMoviesRepository {
    
    private static let cache = NSCache<AnyObject, AnyObject>()
    static let instance: IMoviesRepository = MoviesRepository()
    
    var urlComponents = URLComponents(string: "\(MovieDbUrl.BASE_URL)\(MovieDbUrl.POPULAR_MOVIES)")
    var queryItems = [URLQueryItem(name: "api_key", value: MovieDbUrl.API_KEY)]
    
    private let urlSession: URLSession = URLSession.shared
    
    func fetchPopularMovies(responseData: @escaping (MoviesResponse) -> Void, errorHandler: @escaping (Bool) -> Void) {
        urlComponents!.queryItems = queryItems
        urlSession.dataTask(with: urlComponents!.url!) { (data, response, error) in
            if error != nil {
                errorHandler(true)
                return
            }
            do {
                let movie = try JSONDecoder().decode(MoviesResponse.self, from: data!)
                DispatchQueue.main.async {
                    responseData(movie)
                }
            } catch {
                DispatchQueue.main.async {
                    errorHandler(true)
                }
            }
        }.resume()
    }
    
    func fetchImage(from imageUrl: URL, imageData: @escaping (UIImage) -> (), errorHandler: @escaping( _ errorState: Bool) -> Void) {
        
        if let fromCache = MoviesRepository.cache.object(forKey: imageUrl as AnyObject) as? UIImage {
               imageData(fromCache)
               return
           }
        
        urlSession.dataTask(with: imageUrl) { (data, response, error) in
            if error != nil {
                errorHandler(true)
                return
            }
            
            guard let image = UIImage(data: data!) else {
                return
            }
            MoviesRepository.cache.setObject(image, forKey: imageUrl as AnyObject)
            DispatchQueue.main.async {
                imageData(image)
            }
        }.resume()
    }
}

struct MovieDbUrl {
    static let API_KEY = "01c5d0d1ff15325934327ab3965e26f6"
    static let BASE_URL = "https://api.themoviedb.org/3/movie/"
    static let POPULAR_MOVIES = "popular"
}


