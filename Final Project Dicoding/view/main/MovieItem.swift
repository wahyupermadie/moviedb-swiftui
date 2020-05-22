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
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(self.Grid, id: \.self){ i in
                        HStack(spacing: 15){
                            ForEach(i...i+1, id: \.self){ (j: Int) in
                                MovieItem(movie: self.movies[j], popularMovieVM: PopularMovieViewModel())
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
        self.Grid.removeAll()
        for i in stride(from: 0, to: self.movies.count, by: 2){
            self.Grid.append(i)
        }
    }
}

struct MovieItem : View {
    var movie: Movie?
    @State var isModal: Bool = false
    @ObservedObject var popularMovieVM : PopularMovieViewModel = PopularMovieViewModel()
    var body: some View {
        Button(action: {
            self.isModal = true
        }){
            VStack(alignment: .center, spacing: 8){
                if self.popularMovieVM.movieImage != nil {
                    Image(uiImage: self.popularMovieVM.movieImage!)
                    .resizable()
                    .renderingMode(.original)
                        .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 260)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                }else{
                    Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 260)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                }
                Text(String(self.movie?.title ?? ""))
                    .padding(.bottom, 16)
                    .foregroundColor(.black)
                    .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 60)
                    .lineLimit(2)
            }.onAppear(perform: {
                self.popularMovieVM.downloadImage(urlImage: getPosterPathUrl(url: self.movie?.posterPath))
            })
        }
        .sheet(isPresented: self.$isModal){
            DetailContentView(movie: self.movie!)
        }
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieContainer(movies: fakes)
    }
}
