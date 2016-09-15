//
//  Last+CoreDataProperties.swift
//  NamePicker
//
//  Created by Emily Lynam on 9/14/16.
//  Copyright © 2016 Emily Lynam. All rights reserved.
//

import Foundation
import CoreData


extension Last {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Last> {
        return NSFetchRequest<Last>(entityName: "Last");
    }

    @NSManaged public var name: String?

}
