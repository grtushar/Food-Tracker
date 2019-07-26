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
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        self.name = name
        self.image = image
        self.rating = rating
    }
}
