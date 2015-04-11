//
//  EditCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/1.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class EditCell: BaseCell {
    
    private let label = UILabel()
    private let textField = UITextField()
    
    override class var defaultReuseIdentifier: String {
        return "EditCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont.systemFontOfSize(15.0)
        self.contentView.addSubview(label)
        
        textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        textField.font = UIFont.systemFontOfSize(15.0)
        textField.borderStyle = UITextBorderStyle.None
        textField.textAlignment = NSTextAlignment.Center
        self.contentView.addSubview(textField)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["label": label, "textField": textField],
            formats: "V:|-8-[label]-8-|",
                     "V:|-8-[textField]-8-|",
                     "H:|-16-[label]",
                     "H:[textField(240)]-8-|"))
    }
    
    func setAll(#label: String, textField: String, fieldTag: Int, delegate: UITextFieldDelegate) {
        self.label.text = label
        self.textField.text = textField
        self.textField.tag = fieldTag
        self.textField.delegate = delegate
    }

}
