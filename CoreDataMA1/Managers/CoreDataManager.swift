//
//  CoreDataManager.swift
//  CoreDataMA1
//
//  Created by Duncan Kent on 10/02/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData failed to init \(error.localizedDescription)")
            }
        }
    }
    
    func saveMovie(title: String) {
        
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie saved")
        } catch {
            print("Failed to save movie \(error.localizedDescription)")
        }
        
    }
    
    func getAllMovies() -> [Movie] {
        
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func deleteMovie(movie: Movie) {
        
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie changes saved")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save movie changes \(error.localizedDescription)")
        }
        
    }
    
    func updateMovie() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to update movie changes \(error.localizedDescription)")
        }
        
    }
    
}
