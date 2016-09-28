//
//  Manga+CoreDataProperties.swift
//  mangaDetails
//
//  Created by Thomas on 28/09/16.
//  Copyright © 2016 Thomas. All rights reserved.
//

import Foundation
import CoreData


extension Manga {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Manga> {
        return NSFetchRequest<Manga>(entityName: "Manga");
    }

    @NSManaged public var author: String?
    @NSManaged public var editor: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?

}
