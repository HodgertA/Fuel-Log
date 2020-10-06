//
//  FoodEntryTableViewController.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-05.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation

import UIKit


class FoodEntryTableViewController: UITableViewController{
    
    var foodSource: [FoodEntry]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsInSec:Int
        if let count = foodSource?.count{
            rowsInSec = count
        }
        else{
            rowsInSec = 0
        }
        return rowsInSec
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "foodEntry", for: indexPath) as? FoodEntryViewCell{
            if let foodEntry = foodSource?[indexPath.row]{
                tableViewCell.configureCell(foodEntry: foodEntry, sender: self)
                cell = tableViewCell
            }
        }
        return cell
    }
    
}

    
