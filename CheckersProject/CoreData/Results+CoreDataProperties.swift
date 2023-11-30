//
//  Results+CoreDataProperties.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 01.12.2021.
//
//

import Foundation
import CoreData


extension Results {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Results> {
        return NSFetchRequest<Results>(entityName: "Results")
    }

    @NSManaged public var player1: String?
    @NSManaged public var player2: String?
    @NSManaged public var winner: String?
    @NSManaged public var gameTime: String?
    @NSManaged public var gameDate: String?

    func convert(by results: Results_m) {
        self.player1 = results.player1
        self.player2 = results.player2
        self.winner = results.winner
        self.gameTime = results.gameTime
        self.gameDate = results.gameDate
    }
}

extension Results : Identifiable {

}
