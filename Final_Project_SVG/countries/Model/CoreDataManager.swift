//
//  CoreDataManager.swift
//  countries
//
//  Created by user163874 on 4/16/20.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager 
{
        func addNewCountry(country : Country) {

                let createCounrty = CountryData(context: persistentContainer.viewContext)
                createCounrty.name = country.name
                createCounrty.area = country.area!
                createCounrty.capital = country.capital
                createCounrty.flagImage = country.flagImage
                createCounrty.flag = country.flag
                createCounrty.subRegion = country.subRegion
                createCounrty.population = country.population!
                createCounrty.region = country.region
                
                saveContext()
            }
            
            func fetchToDO()->[CountryData]  {
                
                let fetch : NSFetchRequest = CountryData.fetchRequest()
                
                fetch.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
                
                var results = [CountryData]()
                do {
                    results = try persistentContainer.viewContext.fetch(fetch) as [CountryData]
                }catch {
                    
                }
             return results
                
            }
            
            func createFetchedResultsControllerForEntityNamed<T>(_ entityName: String, withPredicateFormat predicate: String?, predicateObject: [AnyObject]?, sortDescriptors: [NSSortDescriptor]?, andSectionNameKeyPath sectionName: String?) -> NSFetchedResultsController<T> {
                                
                let managedObjectContext = persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<T>()
                
                let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
                fetchRequest.entity = entity
                
                fetchRequest.fetchBatchSize = 20
                
                if let predicate = predicate, let predicateObject = predicateObject {
                    fetchRequest.predicate = NSPredicate(format: predicate, argumentArray: predicateObject)
                }
                
                if let sortDescriptors = sortDescriptors {
                    fetchRequest.sortDescriptors = sortDescriptors
                }
                
                
                return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:managedObjectContext, sectionNameKeyPath: sectionName, cacheName: nil)
            }

            
            lazy var persistentContainer: NSPersistentContainer = {
                
                let container = NSPersistentContainer(name: "CountryData")
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
                    } catch {
                      
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }
                }
            }

        }


