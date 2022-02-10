//
//  MovieDetailView.swift
//  CoreDataMA1
//
//  Created by Duncan Kent on 10/02/2022.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManager
    @Environment(\.dismiss) var dismiss
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            TextField(movie.title ?? "Unknown Name", text: $movieName)
                .textFieldStyle(.roundedBorder)
            Button("Update") {
                if !movieName.isEmpty {
                    movie.title = movieName
                    coreDM.updateMovie()
                    needsRefresh.toggle()
                    dismiss()
                }
            }
        }
        .padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let coreDM = CoreDataManager()
        
        let movie = Movie(context: coreDM.persistentContainer.viewContext)
        
        MovieDetailView(movie: movie, coreDM: coreDM, needsRefresh: .constant(false))
    }
}
