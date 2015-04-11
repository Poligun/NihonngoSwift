//
//  ExampleCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/31.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import UIKit

class ExampleCell: BaseCell {
    
    private let exampleLabel = UILabel()
    private let translationLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "ExampleCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        exampleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        exampleLabel.font = UIFont.systemFontOfSize(13.0)
        exampleLabel.lineBreakMode = .ByWordWrapping
        exampleLabel.numberOfLines = 0
        exampleLabel.textColor = UIColor.blackColor()
        self.contentView.addSubview(exampleLabel)
        
        translationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        translationLabel.font = UIFont.systemFontOfSize(13.0)
        translationLabel.lineBreakMode = .ByWordWrapping
        translationLabel.numberOfLines = 0
        translationLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(translationLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["exampleLabel": exampleLabel, "translationLabel": translationLabel],
            formats: "V:|-8-[exampleLabel]-[translationLabel]-8-|",
                     "H:|-24-[exampleLabel]",
                     "H:|-24-[translationLabel]-8-|"))
    }
    
    func setExample(example: Example) {
        exampleLabel.text = example.example
        translationLabel.text = example.translation
    }

}
