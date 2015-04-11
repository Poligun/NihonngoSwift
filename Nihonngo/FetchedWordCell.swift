//
//  FetchedWordCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/10.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class FetchedWordCell: BaseCell {
    
    private let wordLabel = UILabel()
    private let stateLabel = UILabel()
    private let typesLabel = UILabel()
    private let meaningsLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "FetchedWordCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        wordLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        wordLabel.font = UIFont.systemFontOfSize(15.0)
        wordLabel.textColor = UIColor.blackColor()
        self.contentView.addSubview(wordLabel)
        
        stateLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        stateLabel.font = UIFont.systemFontOfSize(15.0)
        stateLabel.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(stateLabel)
        
        typesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        typesLabel.font = UIFont.systemFontOfSize(15.0)
        typesLabel.textColor = UIColor.darkGrayColor()
        self.contentView.addSubview(typesLabel)
        
        meaningsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        meaningsLabel.font = UIFont.systemFontOfSize(15.0)
        meaningsLabel.textColor = UIColor.blackColor()
        meaningsLabel.lineBreakMode = .ByWordWrapping
        meaningsLabel.numberOfLines = 0
        self.contentView.addSubview(meaningsLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["wordLabel": wordLabel, "stateLabel": stateLabel, "typesLabel": typesLabel, "meaningsLabel": meaningsLabel],
            formats: "V:|-32-[typesLabel(20)]-16-[meaningsLabel]-8-|",
                     "V:|-8-[wordLabel(20)]",
                     "V:|-8-[stateLabel(20)]",
                     "H:|-8-[wordLabel]-[stateLabel]-8-|",
                     "H:|-8-[typesLabel]-8-|",
                     "H:|-8-[meaningsLabel]-8-|"))
    }
    
    func setFetchedWord(word: FetchedWord) {
        wordLabel.text = "\(word.word)（\(word.kana)）"
        typesLabel.text = "，".join(word.types.map{$0.rawValue})
        meaningsLabel.text = word.meanings.stringByReplacingOccurrencesOfString("$", withString: " / ")
            .stringByReplacingOccurrencesOfString("*", withString: "\n\t")
            .stringByReplacingOccurrencesOfString("#", withString: "\n\n")
    }
    
    func setState(state: String) {
        stateLabel.text = state
    }

}
