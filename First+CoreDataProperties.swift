//
//  First+CoreDataProperties.swift
//  NamePicker
//
//  Created by Emily Lynam on 9/14/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation
import CoreData


extension First {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<First> {
        return NSFetchRequest<First>(entityName: "First");
    }

    @NSManaged public var name: String?

}
