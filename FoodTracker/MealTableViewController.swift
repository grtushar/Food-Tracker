//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Md Golam Rahman Tushar on 27/7/19.
//  Copyright © 2019 Md Golam Rahman Tushar. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    // Mark: Properties
    var meals = [Meal]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load the saved or sample data.
        if let savedData = loadMeals() {
            meals += savedData
        } else {
            //loadSampleMealData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        // Configure the cell...
        
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.mealImage.image = meal.image
        cell.ratingControl.rating = meal.rating

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError()
        }
    }
    
    // Mark: Action
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the meals
            saveMeals()
        }
    }
    
    // Mark: Private Methods
    
    private func loadSampleMealData() {
        let riceImage = UIImage(named: "rice")
        let pastaImage = UIImage(named: "pasta")
        let pizzaImage = UIImage(named: "pizza")
        
        guard let rice = Meal(name: "Rice", image: riceImage, rating: 3) else {
            fatalError()
        }
        
        guard let pasta = Meal(name: "Pasta", image: pastaImage, rating: 5) else {
            fatalError()
        }
        
        guard let pizza = Meal(name: "Pizza", image: pizzaImage, rating: 5) else {
            fatalError()
        }
        
        meals.append(rice)
        meals.append(pasta)
        meals.append(pizza)
        
        meals += [rice, pasta, pizza]
    }

    private func saveMeals() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            defaults.set(data, forKey: "meals")
//            try data.write(to: Meal.ArchiveURL)
        } catch {
            
        }
    }
    
    private func loadMeals() -> [Meal]? {
        if let placesData = defaults.object(forKey: "meals") as? NSData {
            let meals = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as! [Meal]
            return meals
        } else {
            return nil
        }
//        do {
//            guard let codedData = try? Data(contentsOf: Meal.ArchiveURL) else { fatalError() }
//
//            guard let meals = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? [Meal] else {
//                fatalError("loadWidgetDataArray - Can't get Array")
//            }
//            return meals
//        } catch {
//            fatalError("loadWidgetDataArray - Can't encode data: \(error)")
//        }
    }
}
