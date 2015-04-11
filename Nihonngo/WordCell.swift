//
//  WordCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/2.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class WordCell: BaseCell {
    
    private let wordLabel = UILabel()
    private let kanaLabel = UILabel()
    
    override class var defaultReuseIdentifier: String {
        return "WordCell"
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
        
        kanaLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        kanaLabel.font = UIFont.systemFontOfSize(15.0)
        kanaLabel.textColor = UIColor.lightGrayColor()
        self.contentView.addSubview(kanaLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["wordLabel": wordLabel, "kanaLabel": kanaLabel],
            formats: "V:|-8-[wordLabel]-8-|",
                     "V:|-8-[kanaLabel]-8-|",
                     "H:|-8-[wordLabel]-[kanaLabel]"))
    }
    
    func setWord(word: Word) {
        wordLabel.text = word.word
        kanaLabel.text = "（\(word.kana)）"
    }
    
}
