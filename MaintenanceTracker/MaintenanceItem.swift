//
//  MaintenanceItem.swift
//  MaintenanceTracker
//
//  Created by Daniel Ratner on 12/14/20.
//  Copyright © 2020 Daniel Ratner. All rights reserved.
//

import Foundation
import CoreData

public class MaintenanceItem:NSManagedObject, Identifiable {
    
    //Gather all attributes
    @NSManaged public var createdAt:Date?
    @NSManaged public var title:String?
    @NSManaged public var milleage:String?
    @NSManaged public var itemDescription:String?
}

extension MaintenanceItem {
    //Request all the items
    static func getAllMaintenanceItems() -> NSFetchRequest<MaintenanceItem> {
        let request:NSFetchRequest<MaintenanceItem> = MaintenanceItem.fetchRequest() as! NSFetchRequest<MaintenanceItem>
        //Sort by date created
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
        
    }
}
