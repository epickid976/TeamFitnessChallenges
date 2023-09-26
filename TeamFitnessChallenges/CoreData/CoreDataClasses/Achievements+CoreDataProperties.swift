//
//  Achievements+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension Achievements {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievements> {
        return NSFetchRequest<Achievements>(entityName: "Achievements")
    }

    @NSManaged public var user: String?
    @NSManaged public var type: String?
    @NSManaged public var eventId: String?
    @NSManaged public var date: Int64

}

extension Achievements : Identifiable {

}
