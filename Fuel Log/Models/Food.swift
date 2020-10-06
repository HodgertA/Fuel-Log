//
//  Food.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-02.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
class Food {
    let foodName: String
    let cals: Int
    let protein: Int
    let fats: Int
    let carbs: Int
    
    init( foodName: String, cals: Int, protein: Int, fats: Int, carbs: Int){
        self.foodName = foodName
        self.cals = cals
        self.protein = protein
        self.fats = fats
        self.carbs = carbs
    }
}
