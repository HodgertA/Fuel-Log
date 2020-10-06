//
//  pastLogs.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-05.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation

class PastLogs{
    var pastLogs: [FoodEntry]
    var date: Date
    
    init(pastLogs: [FoodEntry], date: Date){
        self.pastLogs = pastLogs
        self.date = date
    }
}
