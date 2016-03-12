//
//  FlixPixItem+CoreDataProperties.swift
//  6_87_FlixPix
//
//  Created by Edward P. Kelly on 3/11/16.
//  Copyright © 2016 Edward P. Kelly, LLC. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension FlixPixItem {

    @NSManaged var imageData: NSData?
    @NSManaged var imdbLink: String?
    @NSManaged var itemDesc: String?
    @NSManaged var itemPlot: String?
    @NSManaged var title: String?

}
