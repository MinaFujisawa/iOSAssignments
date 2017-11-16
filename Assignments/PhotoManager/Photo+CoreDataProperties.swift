//
//  Photo+CoreDataProperties.swift
//  PhotoManager
//
//  Created by MINA FUJISAWA on 2017/10/29.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var city: String?
    @NSManaged public var image: UIImage?

}
