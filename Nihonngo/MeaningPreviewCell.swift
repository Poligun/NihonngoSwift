//
//  MeaningPreviewCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/5.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class MeaningPreviewCell: BaseCell {
    
    private let meaningLabel = UILabel()
    private let examplesLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "MeaningPreviewCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        meaningLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        meaningLabel.font = UIFont.systemFontOfSize(15.0)
        meaningLabel.textColor = UIColor.blackColor()
        meaningLabel.lineBreakMode = .ByWordWrapping
        meaningLabel.numberOfLines = 0
        self.contentView.addSubview(meaningLabel)
        
        examplesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        examplesLabel.font = UIFont.systemFontOfSize(13.0)
        examplesLabel.textColor = UIColor.blackColor()
        examplesLabel.lineBreakMode = .ByWordWrapping
        examplesLabel.numberOfLines = 0
        self.contentView.addSubview(examplesLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["meaningLabel": meaningLabel, "examplesLabel": examplesLabel],
            formats: "V:|-8-[meaningLabel]-2-[examplesLabel]-8-|",
                     "H:|-8-[meaningLabel]-8-|",
                     "H:|-8-[examplesLabel]-8-|"))
    }
    
    func setMeaning(meaning: Meaning) {
        meaningLabel.text = meaning.meaning
        examplesLabel.text = "\n".join((meaning.examples.array as [Example]).map{"\t\($0.example) / \($0.translation)"})
    }
}
