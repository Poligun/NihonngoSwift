//
//  LoadingCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/13.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class LoadingCell: BaseCell {
    
    private let label = UILabel()
    private let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override class var defaultReuseIdentifier: String {
        return "LoadingCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.font = UIFont.systemFontOfSize(15.0)
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        self.contentView.addSubview(label)
        
        indicator.setTranslatesAutoresizingMaskIntoConstraints(false)
        indicator.startAnimating()
        self.contentView.addSubview(indicator)

        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["label": label, "indicator": indicator],
            formats: "V:|-8-[label]-8-|",
                     "V:|-8-[indicator]-8-|",
                     "H:|-8-[label]-8-|",
                     "H:[indicator]-8-|"))
    }
    
    func setLoadingText(text: String, animating: Bool) {
        label.text = text
        if animating {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
        }
    }

}
