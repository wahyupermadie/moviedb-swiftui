//
//  MovieItem.swift
//  Final Project Dicoding
//
//  Created by Wahyu Permadi on 17/05/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI

struct MovieItem: View {
    var movies: [Movie]
    var body: some View {
        ForEach(self.movies, id: \.title){ (result: Movie) in
            Text(result.title ?? "")
        }
    }
}

struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieItem(movies: fakes)
    }
}
