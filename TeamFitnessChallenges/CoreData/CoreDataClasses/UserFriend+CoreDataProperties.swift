//
//  UserFriend+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension UserFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserFriend> {
        return NSFetchRequest<UserFriend>(entityName: "UserFriend")
    }

    @NSManaged public var user1: String?
    @NSManaged public var user2: String?
    @NSManaged public var startDate: Int64

}

extension UserFriend : Identifiable {

}
