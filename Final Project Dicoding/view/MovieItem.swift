//
//  MovieItem.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 17/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct MovieContainer: View {
    var movies: [Movie]
    @State var Grid: [Int] = []
    
    var body: some View {
        VStack {
            if !self.Grid.isEmpty {
                ScrollView(.vertical, showsIndicators: true){
                    ForEach(self.Grid, id: \.self){ i in
                        HStack(spacing: 15){
                            ForEach(i...i+1, id: \.self){ (j: Int) in
                                MovieItem(movie: self.movies[j])
                            }
                        }
                    }
                }
            }
        }.onAppear(perform: {
            self.generateGrid()
        })
    }
    
    func generateGrid(){
        for i in stride(from: 0, to: self.movies.count, by: 2){
            self.Grid.append(i)
        }
    }
}

struct MovieItem : View {
    var movie: Movie?
    @ObservedObject var popularMovieVM : PopularMovieViewModel =  PopularMovieViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            if popularMovieVM.movieImage != nil {
                Image(uiImage: popularMovieVM.movieImage!)
                .resizable()
                .renderingMode(.original)
                    .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 260)
                .cornerRadius(5)
                .shadow(radius: 10)
            }
            Text(movie?.title ?? "")
        }.onAppear(perform: {
            self.popularMovieVM.downloadImage(urlImage: (self.movie?.posterPath!.getPosterPathUrl())!)
        })
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieContainer(movies: fakes)
    }
}
