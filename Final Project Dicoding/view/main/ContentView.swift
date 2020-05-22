//
//  ContentView.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 16/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int? = nil
    @ObservedObject var popularMovieVM : PopularMovieViewModel =  PopularMovieViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if popularMovieVM.isLoading {
                    ActivityIndicatorView()
                }else{
                    ForEach(popularMovieVM.results) { (row: MovieRow) in
                        MovieContainer(movies: row.movies)
                    }
                }
            }
            .onDisappear(
                perform: {
                    self.popularMovieVM.results.removeAll()
            })
                .onAppear(
                    perform: {
                        self.popularMovieVM.isLoading = true
                        self.popularMovieVM.fetchPopularMovies()
                }
            )
                .navigationBarTitle("Popular Movies")
                .navigationBarItems(trailing:
                    HStack {
                        NavigationLink(destination: ProfileView(), tag: 1, selection: $selection){
                            Button(action: {
                                self.selection = 1
                                
                            }){
                                Image("person")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
