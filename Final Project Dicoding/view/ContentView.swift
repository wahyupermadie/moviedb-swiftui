//
//  ContentView.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 16/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var popularMovieVM : PopularMovieViewModel =  PopularMovieViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                if popularMovieVM.isLoading {
                    ActivityIndicatorView()
                }else{
                    ForEach(popularMovieVM.results) { (row: MovieRow) in
                        MovieContainer(movies: row.movies)
                    }
                    
                }
            }
            .navigationBarTitle("Popular Movies")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        
                    }){
                        Image("person")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 25, height: 25)
                    }
                }
            )
        }.onAppear(
            perform: {
                self.popularMovieVM.fetchPopularMovies()
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
