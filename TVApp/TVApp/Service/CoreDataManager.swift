//
//  CoreDataManager.swift
//  TVApp
//
//  Created by bean Milky on 2021/01/29.
//

import UIKit
import CoreData

class CoreDataManager {
    var favorites: [NSManagedObject] = []
    
    init() {
        self.load()
    }

    func save(tvModel: TvModel) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
        favorite.setValue(tvModel.channelId, forKeyPath: "channelId")
        favorite.setValue(tvModel.displayTitle, forKeyPath: "displayTitle")
        favorite.setValue(tvModel.id, forKeyPath: "id")
        favorite.setValue(tvModel.videoType.rawValue, forKeyPath: "videoType")
        do {
            try managedContext.save()
            favorites.append(favorite)
        } catch let error as NSError {
            return
        }
    }
    func load() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        do {
            if let favorites = try managedContext.fetch(fetchRequest) as? [Favorite] {
                for favorite in favorites {
                    self.favorites.append(favorite)
                }
            }
        } catch let error as NSError {
            return
        }
    }
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                managedContext.delete(objectData)
            }
        } catch let error {
            return
        }
    }
}
