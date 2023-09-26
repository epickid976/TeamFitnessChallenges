//
//  ChallengeUser+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension ChallengeUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChallengeUser> {
        return NSFetchRequest<ChallengeUser>(entityName: "ChallengeUser")
    }

    @NSManaged public var challenge: String?
    @NSManaged public var user: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var lastDate: Int64

}

extension ChallengeUser : Identifiable {

}
