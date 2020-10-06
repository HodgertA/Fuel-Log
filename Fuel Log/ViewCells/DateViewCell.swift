//
//  DateViewCell.swift
//  Fuel Log
//
//  Created by Aidan on 2020-10-05.
//  Copyright © 2020 Aidan. All rights reserved.
//

import Foundation
import UIKit
class DateViewCell: UITableViewCell{
    
    @IBOutlet weak var dateLabel: UILabel!
    func configureCell(pastLog: PastLogs){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, y"
        dateLabel.text = dateFormatter.string(from: pastLog.date)
    }
}
