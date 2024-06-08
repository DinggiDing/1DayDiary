//
//  DB_core+CoreDataProperties.swift
//  Diary
//
//  Created by 성재 on 3/2/24.
//
//

import Foundation
import CoreData


extension DB_core {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DB_core> {
        return NSFetchRequest<DB_core>(entityName: "DB_core")
    }

    @NSManaged public var status: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var text_align: Int16
    @NSManaged public var text_spacing: Int16
    @NSManaged public var image: [URL]
    
    @NSManaged public var emotions: Int16
    @NSManaged public var weathers: Int16
    
}

extension DB_core : Identifiable {

}
