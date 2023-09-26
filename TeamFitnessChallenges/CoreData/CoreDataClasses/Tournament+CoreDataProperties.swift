//
//  Tournament+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension Tournament {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tournament> {
        return NSFetchRequest<Tournament>(entityName: "Tournament")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var targetType: String?
    @NSManaged public var targetQuantity: String?
    @NSManaged public var status: String?
    @NSManaged public var startDate: Int64
    @NSManaged public var endDate: Int64
    @NSManaged public var image: String?

}

extension Tournament : Identifiable {

}
