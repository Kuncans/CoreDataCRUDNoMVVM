//
//  ContentView.swift
//  CoreDataMA1
//
//  Created by Duncan Kent on 10/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State private var movieName: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var needsRefresh: Bool = false
    
    private func populateMovies() {
        movies = coreDM.getAllMovies()
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TextField("Enter Movie Name", text: $movieName)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save") {
                    coreDM.saveMovie(title: movieName)
                    populateMovies()
                    movieName = ""
                }
                
                List {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie,
                                            coreDM: coreDM,
                                            needsRefresh: $needsRefresh)
                        } label: {
                            Text(movie.title ?? "Unknown Title")
                        }
                    }
                    
                    .onDelete(perform: { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            coreDM.deleteMovie(movie: movie)
                            populateMovies()
                        }
                    })
                }
                .listStyle(.plain)
    
                Spacer()
                
            }
            .padding()
            .onAppear {
                populateMovies()
            }
        }.navigationBarHidden(needsRefresh ? true : true)
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
