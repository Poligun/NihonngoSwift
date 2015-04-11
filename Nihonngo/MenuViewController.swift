
//
//  MenuViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/30.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let menuItemTitles = ["单词列表", "背单词", "批量导入"]
    private let viewControllerNames = ["WordListView", "SelectionTestView", "BatchFetchView"]
    
    private var tableView: UITableView!
    
    var slideViewController: SlideViewController?
    
    convenience init(slideViewController: SlideViewController) {
        self.init()
        self.slideViewController = slideViewController
        
        let wordListViewController = WordListViewController()
        wordListViewController.slideViewDelegate = slideViewController
        slideViewController.addCenterViewController(UINavigationController(rootViewController: wordListViewController), forName: viewControllerNames[0])
        
        let selectionTestGenerator = SelectionTestGenerator()
        let firstTest = selectionTestGenerator.generateFromWords(DataStore.sharedInstance.allWords)
        let selectionTestViewController = SelectionTestViewController(description: firstTest.description, options: firstTest.options, rightOptionIndex: firstTest.rightOptionIndex) {
            (viewController: SelectionTestViewController, selectedIndex: Int) -> Void in
            let nextTest = selectionTestGenerator.generateFromWords(DataStore.sharedInstance.allWords)
            viewController.setTestDescription(nextTest.description)
            viewController.options = nextTest.options
            viewController.rightOptionIndex = nextTest.rightOptionIndex
            viewController.reloadData()
        }
        selectionTestViewController.slideViewDelegate = slideViewController
        slideViewController.addCenterViewController(UINavigationController(rootViewController: selectionTestViewController), forName: viewControllerNames[1], setAsCurrent: false)
        
        let batchFetchViewController = BatchFetchViewController()
        batchFetchViewController.slideViewDelegate = slideViewController
        slideViewController.addCenterViewController(UINavigationController(rootViewController: batchFetchViewController), forName: viewControllerNames[2], setAsCurrent: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.currentTheme.menuViewBackgroundColor
        
        tableView = addTableView(heightStyle: .Fixed(50.0), cellClasses: MenuItemCell.self)
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        addConstraints("V:|-100-[tableView]-60-|", "H:|-0-[tableView]-0-|")

        tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MenuItemCell.defaultReuseIdentifier, forIndexPath: indexPath) as MenuItemCell
        cell.setMenuItemTitle(menuItemTitles[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        slideViewController?.setCenterViewControllerForName(viewControllerNames[indexPath.row])
    }
}
