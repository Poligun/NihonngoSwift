//
//  BaseViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/16.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var views = [String: UIView]()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        if navigationController != nil {
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        }
    }
    
    // Functions of Constraints
    
    func addConstraints(visualFormats: String...) {
        for visualFormat in visualFormats {
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormat, options: .allZeros, metrics: nil, views: views))
        }
    }
    
    // Functions of NavigationBar

    private var rightItems = [UIBarButtonItem]()
    private var rightItemOnClickFunctions = [OnClickFunction]()
    
    private struct OnClickFunction {
        var onClick: ((sender: UIBarButtonItem) -> Void)?
    }
    
    func addRightBarButtonItem(title: String, style: UIBarButtonItemStyle = .Plain, onClick: ((sender: UIBarButtonItem) -> Void)?) {
        let newRightItem = UIBarButtonItem(title: title, style: style, target: self, action: "onRightItemClick:")

        newRightItem.tag = rightItems.count
        rightItems.append(newRightItem)
        rightItemOnClickFunctions.append(OnClickFunction(onClick: onClick))
        navigationItem.rightBarButtonItems = rightItems
    }
    
    func onRightItemClick(sender: UIBarButtonItem) {
        for var i = 0; i < rightItems.count; i++ {
            if sender == rightItems[i] {
                rightItemOnClickFunctions[i].onClick?(sender: sender)
                break
            }
        }
    }
    
    private var leftItemOnClickFunction: OnClickFunction?
    
    func setLeftBarButtonItem(title: String, style: UIBarButtonItemStyle = .Plain, onClick: ((sender: UIBarButtonItem) -> Void)?) {
        let newLeftItem = UIBarButtonItem(title: title, style: style, target: self, action: "onLeftItemClick:")
        
        leftItemOnClickFunction = OnClickFunction(onClick: onClick)
        navigationItem.leftBarButtonItem = newLeftItem
    }
    
    func onLeftItemClick(sender: UIBarButtonItem) {
        leftItemOnClickFunction?.onClick?(sender: sender)
    }
    
    // Functions of Adding Components
    
    private func addView(view: UIView, forName name: String) {
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        views[name] = view
        self.view.addSubview(view)
    }
    
    func addTextView(name: String = "textView", frame: CGRect? = nil, font: UIFont? = UIFont.systemFontOfSize(15.0), editable: Bool = false, selectable: Bool = true) -> UITextView {
        let textView = frame == nil ? UITextView() : UITextView(frame: frame!)
        
        textView.font = font
        textView.editable = editable
        textView.selectable = selectable
        addView(textView, forName: name)
        
        return textView
    }

    enum TableViewHeightStyle {
        case Fixed(CGFloat)
        case Dynamic(CGFloat)
    }
    
    func addTableView(name: String = "tableView", frame: CGRect? = nil, style: UITableViewStyle = .Grouped, heightStyle: TableViewHeightStyle, cellClasses: BaseCell.Type...) -> UITableView {
        let tableView = frame == nil ? UITableView() : UITableView(frame: frame!)
        
        switch heightStyle {
        case .Fixed(let rowHeight):
            tableView.rowHeight = rowHeight
        case .Dynamic(let estimatedRowHeight):
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = estimatedRowHeight
        }

        if let dataSource = self as? UITableViewDataSource {
            tableView.dataSource = dataSource
        }
        if let delegate = self as? UITableViewDelegate {
            tableView.delegate = delegate
        }
        
        for cellClass in cellClasses {
            tableView.registerClass(cellClass, forCellReuseIdentifier: cellClass.defaultReuseIdentifier)
        }
        
        addView(tableView, forName: name)

        return tableView
    }
    
    func addSearchBar(name: String = "searchBar", frame: CGRect? = nil, placeHolder: String = "") -> UISearchBar {
        let searchBar = frame == nil ? UISearchBar() : UISearchBar(frame: frame!)
        
        searchBar.placeholder = placeHolder
        
        if let delegate = self as? UISearchBarDelegate {
            searchBar.delegate = delegate
        }
        
        addView(searchBar, forName: name)

        return searchBar
    }

}
