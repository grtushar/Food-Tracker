//
//  Meal.swift
//  FoodTracker
//
//  Created by Md Golam Rahman Tushar on 26/7/19.
//  Copyright © 2019 Md Golam Rahman Tushar. All rights reserved.
//

import UIKit

class Meal {
    var name: String
    var image: UIImage?
    var rating: Int
    
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
}
