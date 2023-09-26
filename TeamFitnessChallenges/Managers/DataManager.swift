//
//  DataManager.swift
//  TeamFitnessChallenges
//
//  Created by Jose Blanco on 9/26/23.
//

import Foundation
import CoreData
import SwiftUI

class DataManager: NSObject, ObservableObject {
    
    // MARK: - Properties and Initialization
    
        // our private hook into Core Data
    private var managedObjectContext: NSManagedObjectContext
    
        // we use NSFetchedResultsControllers in place of distributed @FetchRequests
        // to keep track of Items and Locations
    private let usersFRC: NSFetchedResultsController<User>
    private let userFriendsFRC: NSFetchedResultsController<UserFriend>
    private let friendRequestsFRC: NSFetchedResultsController<FriendRequest>
    private let challengesFRC: NSFetchedResultsController<Challenge>
    private let challengeUsersFRC: NSFetchedResultsController<ChallengeUser>
    private let tournamentsFRC: NSFetchedResultsController<Tournament>
    private let tournamentTargetsFRC: NSFetchedResultsController<TournamentTarget>
    private let achievementsFRC: NSFetchedResultsController<Achievements>

        // we vend @Published arrays of Items to clients, which
        // are updated internally by the FRC in response
        // to controllerDidChangeContent() firing (we are an NSFetchedResultsControllerDelegate)
    @Published var users = [User]()
    @Published var userFriends = [UserFriend]()
    @Published var friendRequests = [FriendRequest]()
    @Published var challenges = [Challenge]()
    @Published var challengeUsers = [ChallengeUser]()
    @Published var tournaments = [Tournament]()
    @Published var tournamentTargets = [TournamentTarget]()
    @Published var achievements = [Achievements]()
    
    override init() {
        // set up Core Data (we own it)
        let persistentStore = PersistenceController()
        managedObjectContext = persistentStore.container.viewContext
        
            // create NSFetchedResultsControllers here for Items
        let fetchRequest1: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest1.sortDescriptors = [NSSortDescriptor(key: "email", ascending: true)]
        usersFRC = NSFetchedResultsController(fetchRequest: fetchRequest1,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest2: NSFetchRequest<UserFriend> = UserFriend.fetchRequest()
        fetchRequest2.sortDescriptors = [NSSortDescriptor(key: "user1", ascending: false)]
        userFriendsFRC = NSFetchedResultsController(fetchRequest: fetchRequest2,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest3: NSFetchRequest<FriendRequest> = FriendRequest.fetchRequest()
        fetchRequest3.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        friendRequestsFRC = NSFetchedResultsController(fetchRequest: fetchRequest3,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest4: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        fetchRequest4.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        challengesFRC = NSFetchedResultsController(fetchRequest: fetchRequest4,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest5: NSFetchRequest<ChallengeUser> = ChallengeUser.fetchRequest()
        fetchRequest5.sortDescriptors = [NSSortDescriptor(key: "user", ascending: false)]
        challengeUsersFRC = NSFetchedResultsController(fetchRequest: fetchRequest5,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest6: NSFetchRequest<Tournament> = Tournament.fetchRequest()
        fetchRequest6.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        tournamentsFRC = NSFetchedResultsController(fetchRequest: fetchRequest6,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest7: NSFetchRequest<TournamentTarget> = TournamentTarget.fetchRequest()
        fetchRequest7.sortDescriptors = [NSSortDescriptor(key: "tournament", ascending: false)]
        tournamentTargetsFRC = NSFetchedResultsController(fetchRequest: fetchRequest7,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
        
        let fetchRequest8: NSFetchRequest<Achievements> = Achievements.fetchRequest()
        fetchRequest8.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        achievementsFRC = NSFetchedResultsController(fetchRequest: fetchRequest8,
                                                             managedObjectContext: managedObjectContext,
                                                             sectionNameKeyPath: nil, cacheName: nil)
    
            // finish our initialization as an NSObject
        super.init()
        
            // hook ourself in as the delegate of each of these FRCs and do a first fetch to populate
            // the two @Published arrays we vend
        usersFRC.delegate = self
        userFriendsFRC.delegate = self
        friendRequestsFRC.delegate = self
        challengesFRC.delegate = self
        challengeUsersFRC.delegate = self
        tournamentsFRC.delegate = self
        tournamentTargetsFRC.delegate = self
        achievementsFRC.delegate = self
        
        try? usersFRC.performFetch()
        try? userFriendsFRC.performFetch()
        try? friendRequestsFRC.performFetch()
        try? challengesFRC.performFetch()
        try? challengeUsersFRC.performFetch()
        try? tournamentsFRC.performFetch()
        try? tournamentTargetsFRC.performFetch()
        try? achievementsFRC.performFetch()
        
        self.users = usersFRC.fetchedObjects ?? []
        self.userFriends = userFriendsFRC.fetchedObjects ?? []
        self.friendRequests = friendRequestsFRC.fetchedObjects ?? []
        self.challenges = challengesFRC.fetchedObjects ?? []
        self.challengeUsers = challengeUsersFRC.fetchedObjects ?? []
        self.tournaments = tournamentsFRC.fetchedObjects ?? []
        self.tournamentTargets = tournamentTargetsFRC.fetchedObjects ?? []
        self.achievements = achievementsFRC.fetchedObjects ?? []
        
        
    }
    
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
    
    //TODO Add new Items, Delete Items, Update Items
    
}

    // MARK: - FetchedResults Handling

extension DataManager: NSFetchedResultsControllerDelegate {
    
        // we listen for changes to items.
        // it's a simple way to mimic what a @FetchRequest would do in SwiftUI for one of these objects.
        // note: this is most likely the spot where we can identify any cloud latency problem of having
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newUsers = controller.fetchedObjects as? [User] {
            self.users = newUsers
        } else if let newUserFriends = controller.fetchedObjects as? [UserFriend] {
            self.userFriends = newUserFriends
        } else if let newfriendRequests = controller.fetchedObjects as? [FriendRequest] {
            self.friendRequests = newfriendRequests
        } else if let newChallenges = controller.fetchedObjects as? [Challenge] {
            self.challenges = newChallenges
        } else if let newChallengeUsers = controller.fetchedObjects as? [ChallengeUser] {
            self.challengeUsers = newChallengeUsers
        } else if let newTournaments = controller.fetchedObjects as? [Tournament] {
            self.tournaments = newTournaments
        } else if let newTournamentTargets = controller.fetchedObjects as? [TournamentTarget] {
            self.tournamentTargets = newTournamentTargets
        } else if let newAchievements = controller.fetchedObjects as? [Achievements] {
            self.achievements = newAchievements
        }
    }

}
