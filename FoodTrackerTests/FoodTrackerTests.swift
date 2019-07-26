//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Md Golam Rahman Tushar on 8/7/19.
//  Copyright © 2019 Md Golam Rahman Tushar. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // Mark: Meal class test
    
    // Confirms meal class return object when called with appropriate init parameters
    func testMealInitializationSucceds() {
        let perfectMeal = Meal(name: "Salad", image: nil, rating: 5)
        XCTAssertNotNil(perfectMeal)
    }
    
    // Confirms that meal class initialization returns nil if initialized with empty name or negative rating
    func testMealInitializationFails() {
        // Empty name string
        let emptyStringName = Meal(name: "", image: nil, rating: 3)
        XCTAssertNil(emptyStringName)
        
        // Rating exceeds max limit
        let ratingExceedingMeal = Meal(name: "Khichuri", image: nil, rating: 6)
        XCTAssertNil(ratingExceedingMeal)
        
        // Negatative rating
        let negativeRatingMeal = Meal(name: "Rice", image: nil, rating: -2)
        XCTAssertNil(negativeRatingMeal)
    }

}
