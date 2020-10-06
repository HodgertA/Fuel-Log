//
//  FoodEntryViewCell.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-03.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

class FoodEntryViewCell: UITableViewCell{
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var servingNameLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    
    func configureCell(foodEntry: FoodEntry, sender: UIViewController){
        if sender is MainInfoViewController{
            foodNameLabel.text = foodEntry.foodItem.foodName
            servingNameLabel.text = "servings: \(foodEntry.servingCount)"
        }
        else if sender is FoodEntryTableViewController{
            foodLabel.text = foodEntry.foodItem.foodName
            servingLabel.text = "servings: \(foodEntry.servingCount)"
        }
    }
}
