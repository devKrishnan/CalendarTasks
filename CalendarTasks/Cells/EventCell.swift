//
//  EventCell.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 10/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var indicator: UIImageView!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var participants: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
