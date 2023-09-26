//
//  Challenge+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var id: String?
    @NSManaged public var type: String?
    @NSManaged public var name: String?
    @NSManaged public var targetType: String?
    @NSManaged public var targetQuantity: String?
    @NSManaged public var status: String?
    @NSManaged public var startDate: Int64
    @NSManaged public var endDate: Int64
    @NSManaged public var completionDate: Int64

}

extension Challenge : Identifiable {

}
