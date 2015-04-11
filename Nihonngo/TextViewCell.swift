//
//  TextViewCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/8.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class TextViewCell: BaseCell, UITextViewDelegate {
    
    private let textView = UITextView()
    private var onEndEditingFunc: ((textView: UITextView) -> Void)?
    
    override class var defaultReuseIdentifier: String {
        return "TextViewCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.font = UIFont.systemFontOfSize(15.0)
        textView.delegate = self
        self.contentView.addSubview(textView)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["textView": textView],
            formats: "V:|-[textView]-|",
                     "H:|-[textView]-|"))
    }
    
    func setText(text: String, onEndEditing: ((textView: UITextView) -> Void)?) {
        textView.text = text
        onEndEditingFunc = onEndEditing
    }
    
    //TextView Delegate
    
    func textViewDidEndEditing(textView: UITextView) {
        onEndEditingFunc?(textView: textView)
    }
}
