//
//  MyScore+CoreDataProperties.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/30.
//  Copyright © 2019 Scott.com. All rights reserved.
//
//

import Foundation
import CoreData


extension MyScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyScore> {
        return NSFetchRequest<MyScore>(entityName: "MyScore")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var score: String?
    @NSManaged public var level: String?

}
