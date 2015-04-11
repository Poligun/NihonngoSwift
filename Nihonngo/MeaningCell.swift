//
//  MeaningCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/31.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import UIKit

class MeaningCell: BaseCell {
    
    private let meaningLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "MeaningCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        meaningLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        meaningLabel.font = UIFont.systemFontOfSize(15.0)
        meaningLabel.lineBreakMode = .ByWordWrapping
        meaningLabel.numberOfLines = 0
        self.contentView.addSubview(meaningLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["meaningLabel": meaningLabel],
            formats: "V:|-4-[meaningLabel]-4-|",
                     "H:|-8-[meaningLabel]-8-|"))
    }
    
    func setMeaning(meaning: Meaning) {
        meaningLabel.text = "\(meaning.index + 1)、\(meaning.meaning)"
    }

}
