//
//  Meal.swift
//  FoodTracker
//
//  Created by Md Golam Rahman Tushar on 26/7/19.
//  Copyright © 2019 Md Golam Rahman Tushar. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    // Mark: Properties
    var name: String
    var image: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")

    
    // Mark: Types
    struct PropertyKey {
        static let name = "name"
        static let image = "image"
        static let rating = "rating"
    }
    
    init?(name: String, image: UIImage?, rating: Int) {
        
        // Name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Rating must be between 0 to 5 inclusive
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.image = image
        self.rating = rating
    }
    
    // Mark: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, image: image, rating: rating)
    }
    
}
