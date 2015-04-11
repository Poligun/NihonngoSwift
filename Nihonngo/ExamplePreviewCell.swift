//
//  ExamplePreviewCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/8.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class ExamplePreviewCell: BaseCell {

    private let exampleLabel = UILabel()
    private let translationLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "ExamplePreviewCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        exampleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        exampleLabel.font = UIFont.systemFontOfSize(15.0)
        exampleLabel.textColor = UIColor.blackColor()
        exampleLabel.lineBreakMode = .ByWordWrapping
        exampleLabel.numberOfLines = 0
        self.contentView.addSubview(exampleLabel)
        
        translationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        translationLabel.font = UIFont.systemFontOfSize(13.0)
        translationLabel.textColor = UIColor.lightGrayColor()
        translationLabel.lineBreakMode = .ByWordWrapping
        translationLabel.numberOfLines = 0
        self.contentView.addSubview(translationLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["exampleLabel": exampleLabel, "translationLabel": translationLabel],
            formats: "V:|-8-[exampleLabel]-2-[translationLabel]-8-|",
            "H:|-8-[exampleLabel]-8-|",
            "H:|-8-[translationLabel]-8-|"))
    }
    
    func setExample(example: Example) {
        exampleLabel.text = example.example
        translationLabel.text = example.translation
    }

}
