//
//  CoreDataManager.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 01.12.2021.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CheckersResults")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addNewResult(by result_m: Results_m) {
        let result = Results(context: persistentContainer.viewContext)
        result.convert(by: result_m)
        
        persistentContainer.viewContext.insert(result)
        saveContext()
    }
    
    func getResults() -> [Results_m] {
        var array = [Results_m]()
        do {
            let results = try persistentContainer.viewContext.fetch(Results.fetchRequest())
            results.forEach { result in
                array.append(Results_m(from: result))
            }
        } catch (let e) {
            print(e)
        }
        print(array)
        return array
    }

    func removeGameFromResults(by gameTime: String) {
        let request: NSFetchRequest<Results> = Results.fetchRequest()
        request.predicate = NSPredicate(format: "gameTime == %@", gameTime)

        do {
            guard let game = try persistentContainer.viewContext.fetch(request).first else { return }
            persistentContainer.viewContext.delete(game)
            saveContext()
            print("DELETED ONE")
        } catch (let e) {
            print(e)
        }
    }

    func clearAllResults(completion: () -> Void) {
        let request: NSFetchRequest<Results> = Results.fetchRequest()
        let context = persistentContainer.viewContext
        do {
            let results = try context.fetch(request)
            for result in results {
                context.delete(result)
                saveContext()
            }
            completion()
            print("DELETED ALL")
        } catch (let e) {
            print(e)
        }
    }

}
