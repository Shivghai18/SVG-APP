//
//  CountryData+CoreDataProperties.swift
//  countries
//
//  Created by user163874 on 4/16/20.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//
//

import Foundation
import CoreData


extension CountryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryData> {
        return NSFetchRequest<CountryData>(entityName: "CountryData")
    }

    @NSManaged public var area: Double
    @NSManaged public var capital: String?
    @NSManaged public var flag: String?
    @NSManaged public var flagImage: Data?
    @NSManaged public var name: String?
    @NSManaged public var population: Double
    @NSManaged public var region: String?
    @NSManaged public var subRegion: String?

}
