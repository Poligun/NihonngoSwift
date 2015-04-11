//
//  Theme.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/15.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class Theme {
    
    struct Instance {
        static var instance: Theme?
    }
    
    class var currentTheme: Theme {
        if Instance.instance == nil {
            Instance.instance = Theme()
        }
        return Instance.instance!
    }
    
    lazy var menuViewBackgroundColor: UIColor = {
        return UIColor(hue: 214.0 / 360.0, saturation: 0.94, brightness: 0.6, alpha: 1.0)
    }()
    
    lazy var navigationBarBackgroundColor: UIColor = {
        return UIColor(hue: 214.0 / 360.0, saturation: 0.94, brightness: 0.8, alpha: 1.0)
    }()
    
    lazy var searchBarBackgroundColor: UIColor = {
        return self.navigationBarBackgroundColor
    }()
    
    lazy var searchFieldBackgroundColor: UIColor = {
        return UIColor(hue: 214.0 / 360.0, saturation: 0.44, brightness: 1.0, alpha: 1.0)
    }()
    
}
