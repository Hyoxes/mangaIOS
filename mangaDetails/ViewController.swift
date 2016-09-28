//
//  ViewController.swift
//  mangaDetails
//
//  Created by Thomas on 28/09/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let storageURL = documentURL.appendingPathComponent("Manga.db")
        
        let modelURL = Bundle.main.url(forResource: "mangaDetails", withExtension: "momd")
        
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        let store = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        do{
            try store.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageURL, options: nil)
            let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.persistentStoreCoordinator = store
            // self.context = context
        } catch {
            print("Error")
        }
        

        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

