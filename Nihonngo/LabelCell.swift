//
//  LabelCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/9.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class LabelCell: BaseCell {

    private let label = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "LabelCell"
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont.systemFontOfSize(15.0)
        label.textColor = UIColor.blackColor()
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["label": label],
            formats: "V:|-8-[label]-8-|",
                     "H:|-8-[label]-8-|"))
    }

    func setLabelText(text: String, font: UIFont? = nil, textAlignment: NSTextAlignment = .Left) {
        label.text = text
        label.textAlignment = textAlignment
    }

}
