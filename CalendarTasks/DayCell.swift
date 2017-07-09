//
//  DayCell.swift
//  CalendarTasks
//
//  Created by radhakrishnan S on 07/07/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit
import CoreGraphics
class DayCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    var borderView : UIView!
    @IBOutlet weak var dayLabelTopConstraint: NSLayoutConstraint!
    var selectedStateLayer : CAShapeLayer?
    override var isSelected: Bool{
        didSet {
            //It matters to show or hide month only when month label contains text
            
            if let text = monthLabel.text, !text.isEmpty {
                if isSelected {
                    hideMonth()
                }else{
                    showMonth()
                }
            }
            //self.handleSelection()
            
        }
    }
    override func prepareForReuse() {
        showMonth()
        hideSelectionLayer()
    }
    var today: Bool = false{
        didSet{
            if today {
                self.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
                dayLabel.textColor = UIColor.blue
                monthLabel.textColor = UIColor.blue
            }else{
                self.backgroundColor = UIColor.white
                dayLabel.textColor = UIColor.black
                monthLabel.textColor = UIColor.black
            }
            
        }
    }
    func showMonth() -> Void {
        dayLabelTopConstraint.constant = 10
        self.layoutIfNeeded()
        self.monthLabel.isHidden = false
    }
    func hideMonth() -> Void {
        
        self.monthLabel.isHidden = true
        dayLabelTopConstraint.constant = 4
        self.layoutIfNeeded()
        
    }
    
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
    func hideSelectionLayer(){
        self.selectedStateLayer?.removeFromSuperlayer()
        self.selectedStateLayer = nil
    }
    func addSelectionLayer(){

            let minimumDimension = self.bounds.size.width > self.bounds.size.height ?  self.bounds.size.height : self.bounds.size.width
            let originX : CGFloat = self.bounds.size.width/(self.bounds.size.width > self.bounds.size.height ? 5 : 7)
            let originY : CGFloat = self.bounds.size.height/7
            let origin = originX < originY ? originX  : originY
            let bezierPath = UIBezierPath(ovalIn: CGRect(x: originX, y: originY, width: minimumDimension-2*origin, height: minimumDimension-2*origin))
            self.selectedStateLayer = CAShapeLayer()
            self.selectedStateLayer?.path = bezierPath.cgPath
            self.selectedStateLayer?.fillColor = UIColor.green.cgColor
            self.layer.insertSublayer(selectedStateLayer!, at: 0)
    
    }
}
