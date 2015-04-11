//
//  SearchBarExtension.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/10.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func getSearchField() -> UITextField? {
        for view in self.subviews {
            for subView in view.subviews {
                if subView is UITextField {
                    return subView as? UITextField
                }
            }
        }
        return nil
    }

}