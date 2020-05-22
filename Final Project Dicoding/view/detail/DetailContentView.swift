//
//  DetailContentView.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 17/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct DetailContentView: View {
    var movie : Movie
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack(spacing: 16) {
                    ImageData(imageUrl: getPosterPathUrl(url: movie.backdropPath))
                    InfoView(movie: movie)
                    Text("Overview")
                        .font(.title)
                    Text(movie.overview ?? "")
                        .padding([.leading, .trailing], 20)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            }
            .padding(.bottom, 30)
            .navigationBarTitle(movie.originalTitle ?? "")
        }
    }
}

struct InfoView : View {
    var movie: Movie
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("Release Date")
                Text(movie.releaseDate ?? "")
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            VStack(alignment: .center) {
                Text("Popularity")
                Text(String(movie.popularity) ?? "0.0")
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            VStack(alignment: .center) {
                Text("Vote Average")
                Text(String(movie.voteAverage) ?? "0⭐️")
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
        }.padding([.leading, .trailing], 20)
    }
}

struct ImageData : View {
    var imageUrl : URL
    @ObservedObject var popularVM : PopularMovieViewModel = PopularMovieViewModel()
    var body: some View {
        ZStack{
            if self.popularVM.movieImage != nil {
                Image(uiImage: popularVM.movieImage!)
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(5)
                    .padding([.leading, .trailing], 20)
                    .shadow(radius: 10)
                    
            }else{
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: 169)
                    .cornerRadius(5)
                    .shadow(radius: 10)
            }
        }
        .onAppear(perform: {
            self.popularVM.downloadImage(urlImage: self.imageUrl)
        })
    }
}
struct DetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailContentView(movie: fake)
    }
}
