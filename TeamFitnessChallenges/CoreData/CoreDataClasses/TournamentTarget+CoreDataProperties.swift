//
//  TournamentTarget+CoreDataProperties.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//
//

import Foundation
import CoreData


extension TournamentTarget {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TournamentTarget> {
        return NSFetchRequest<TournamentTarget>(entityName: "TournamentTarget")
    }

    @NSManaged public var tournament: String?
    @NSManaged public var quantity: Int64
    @NSManaged public var exp: Int64

}

extension TournamentTarget : Identifiable {

}
