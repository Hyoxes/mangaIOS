//
//  AppDelegate.swift
//  mangaDetails
//
//  Created by Thomas on 28/09/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context:NSManagedObjectContext?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let storageURL = documentURL.appendingPathComponent("mangaDetails")
        
        let modelURL = Bundle.main.url(forResource: "mangaDetails", withExtension: "momd")
        
        print("modelURL : \(modelURL)")
        
        let modelSchema = NSManagedObjectModel(contentsOf: modelURL!)
        print("modelSchema : \(modelSchema)")
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: modelSchema!)
        
        do{
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageURL, options: nil)
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = storeCoordinator
            self.context = context
        } catch {
            print("Error")
        }
        
        //addNewManga(title: "One Piece", synopsis: "La grande aventure pirate", editor: "Glenat", author: "Eiichiro Oda")
        displayManga()

        return true
    }

    
    func addNewManga(title:String, synopsis:String, editor: String, author: String) {
        let m = NSEntityDescription.insertNewObject(forEntityName: "Manga", into: self.context!) as! Manga
        
        m.author = author
        m.editor = editor
        m.synopsis = synopsis
        m.title = title
        
        try? self.context?.save()
    }
    
    func displayManga() {
        let request = NSFetchRequest<Manga>(entityName: "Manga")
        let storeResult = try? self.context?.execute(request) as! NSAsynchronousFetchResult<Manga>
        for m in (storeResult?.finalResult)!{
            print ("\(m.title) \n\(m.author)      \(m.editor)\n\(m.synopsis)")
        }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "mangaDetails")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

