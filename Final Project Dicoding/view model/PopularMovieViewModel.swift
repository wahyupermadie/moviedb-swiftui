//
//  PopularMovieViewModel.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 17/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation

protocol IPopularMovieViewModel {
    func fetchPopularMovies()
}

struct MovieRow: Identifiable {
    
    var categoryName: String
    var movies: [Movie]
    
    var id: String {
        return categoryName
    }
    
}

class PopularMovieViewModel : IPopularMovieViewModel, ObservableObject {
    
    private let repository: IMoviesRepository
    
    @Published var errorResponse: Bool = false
    @Published var isLoading: Bool = false
    @Published var results: [MovieRow] = []
    
    init(repository: IMoviesRepository = MoviesRepository.instance) {
        self.repository = repository
    }
    
    func fetchPopularMovies() {
        isLoading = true
        self.repository.fetchPopularMovies(responseData: { (responseData) in
            self.results.append(MovieRow(categoryName: "popular", movies: responseData.results!))
            self.isLoading = false
        }){ (errorResponse) in
            self.isLoading = false
        }
    }
}
