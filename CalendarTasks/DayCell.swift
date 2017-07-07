//
//  DayCell.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    var borderView : UIView!
    override func awakeFromNib() {
        var frame = self.bounds
        frame.origin.y = self.bounds.height - 1
        frame.size.height = 1
        frame.size.width = self.contentView.frame.size.width
        borderView = UIView(frame: frame)
        borderView.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(borderView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
            borderView.frame =  CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
    }
}
