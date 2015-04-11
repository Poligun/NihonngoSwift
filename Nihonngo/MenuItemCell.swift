//
//  MenuItemCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/31.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import UIKit

class MenuItemCell: BaseCell {
    
    private let label: UILabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "MenuItemCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        
        let view = UIView()
        view.backgroundColor = UIColor(hue: 214.0 / 360.0, saturation: 0.94, brightness: 1.0, alpha: 1.0)
        self.selectedBackgroundView = view

        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont.boldSystemFontOfSize(17.0)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(label)

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["label": label],
            formats: "V:|-8-[label]-8-|",
                     "H:|-0-[label(150)]"))
    }
    
    func setMenuItemTitle(title: NSString) {
        self.label.text = title
    }
    
}
