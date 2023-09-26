//
//  FriendRequest+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension FriendRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendRequest> {
        return NSFetchRequest<FriendRequest>(entityName: "FriendRequest")
    }

    @NSManaged public var fromUser: String?
    @NSManaged public var toUser: String?
    @NSManaged public var date: Int64
    @NSManaged public var status: String?

}

extension FriendRequest : Identifiable {

}
