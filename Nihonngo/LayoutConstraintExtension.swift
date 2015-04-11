//
//  LayoutConstraintExtension.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/6.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    class func constraints(#views: [NSObject : AnyObject], formats: String...) -> [AnyObject] {
        var constraints = [AnyObject]()

        for format in formats {
            if format.hasPrefix("H:") {
                constraints += NSLayoutConstraint.constraintsWithVisualFormat(format, options: .allZeros, metrics: nil, views: views)
            } else {
                constraints += NSLayoutConstraint.constraintsWithVisualFormat(format, options: .allZeros, metrics: nil, views: views)
            }
        }

        return constraints
    }

}
