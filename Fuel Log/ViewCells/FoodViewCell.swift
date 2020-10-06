//
//  FoodViewCell.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-03.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

class FoodViewCell: UITableViewCell{
    
    @IBOutlet weak var foodName: UILabel!
    func configureCell(food: Food){
        foodName.text = food.foodName
    }
}
