//
//  BaseCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/16.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    class var defaultReuseIdentifier: String {
        return "BaseCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

}
