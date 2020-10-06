//
//  DateTableViewController.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-05.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit

protocol LogSource {
    func getPastLog(index: Int) -> PastLogs
    func getLogCount() -> Int
}


class DateTableViewController: UITableViewController{
    var logSource: LogSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsInSec:Int
        if let count = logSource?.getLogCount(){
            rowsInSec = count
        }
        else{
            rowsInSec = 0
        }
        return rowsInSec
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath) as? DateViewCell{
            if let log = logSource?.getPastLog(index: indexPath.row){
                tableViewCell.configureCell(pastLog: log)
                cell = tableViewCell
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
            guard let selectedCell = sender as? UITableViewCell else{
                return
            }
            
            guard let selectedIndexPath = tableView.indexPath(for: selectedCell) else{
                return
            }
            
            guard let foodEntryVC = segue.destination as? FoodEntryTableViewController else{
                return
            }
            
            foodEntryVC.foodSource = logSource?.getPastLog(index: selectedIndexPath.row).pastLogs
    
        }
    }

