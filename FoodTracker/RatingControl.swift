//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Md Golam Rahman Tushar on 23/7/19.
//  Copyright © 2019 Md Golam Rahman Tushar. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // Mark: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStats()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    // Mark: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // Mark: Private Methods
    private func setupButtons() {
        // Remove any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0..<starCount {
            // Create button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            // Setup button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonPressed(button:)), for: .touchUpInside)
            
            // Add button
            addArrangedSubview(button)
            
            // Add button to array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStats()
    }
    
    private func updateButtonSelectionStats() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    // Mark: Button Action
    @objc func ratingButtonPressed(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("This \(button) is not inside the \(ratingButtons) array")
        }
        
        let selectedRating = index + 1
        
        rating = selectedRating == rating ? 0 : selectedRating
    }
}
