//
//  BatchFetchViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/15.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class BatchFetchViewController: FetchWordViewController {

    var slideViewDelegate: SlideViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "批量导入"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: .Plain, target: self, action: "onMenuButtonClick:")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", style: .Plain, target: self, action: "onNextButtonClick:")
    }
    
    func onMenuButtonClick(sender: AnyObject) {
        slideViewDelegate?.toggleLeftView()
    }
    
    func onNextButtonClick(sender: AnyObject) {
        
    }

}
