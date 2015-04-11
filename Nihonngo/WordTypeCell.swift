//
//  WordTypeCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/7.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class WordTypeCell: BaseCell {
    
    private let wordTypeLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "WordTypeCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        wordTypeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        wordTypeLabel.font = UIFont.systemFontOfSize(13.0)
        wordTypeLabel.textColor = UIColor.blackColor()
        wordTypeLabel.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(wordTypeLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["wordTypeLabel": wordTypeLabel],
            formats: "V:|-[wordTypeLabel]-|",
                     "H:|-8-[wordTypeLabel]-8-|"))
    }
    
    func setWordType(wordType: WordType) {
        wordTypeLabel.text = wordType.rawValue
    }

}
