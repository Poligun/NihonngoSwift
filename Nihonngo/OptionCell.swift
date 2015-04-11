//
//  OptionCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/11.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class OptionCell: BaseCell {
    
    private let whiteColor = UIColor.whiteColor()
    private let redColor = UIColor(hue: 360.0 / 360.0, saturation: 0.88, brightness: 0.74, alpha: 1.0)
    private let greenColor = UIColor(hue: 140.0 / 360.0, saturation: 0.88, brightness: 0.74, alpha: 1.0)
    
    private let label = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "OptionCell"
    }
    
    enum OptionState {
        case Normal
        case Right
        case Wrong
    }
    
    var state: OptionState = .Normal {
        didSet {
            switch state {
            case .Normal:
                self.backgroundColor = self.whiteColor
                self.label.textColor = UIColor.blackColor()
            case .Right:
                self.backgroundColor = self.greenColor
                self.label.textColor = UIColor.whiteColor()
            case .Wrong:
                self.backgroundColor = self.redColor
                self.label.textColor = UIColor.whiteColor()
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont.systemFontOfSize(17.0)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["label": label],
            formats: "V:|-8-[label]-8-|",
                     "H:|-8-[label]-8-|"))
    }
    
    func setOption(option: String) {
        label.text = option
    }

}