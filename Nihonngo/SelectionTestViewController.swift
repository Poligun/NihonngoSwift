//
//  SelectionTestViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/11.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class SelectionTestViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let optionCellIdentifier = "OptionCell"

    private var descriptionTextView: UITextView!
    private var tableView: UITableView!
    
    var slideViewDelegate: SlideViewDelegate?
    
    var showOptionNumber = true
    
    var options = [String]()
    var rightOptionIndex: Int = -1
    var onSelection: ((viewController: SelectionTestViewController, selectedIndex: Int) -> Void)?
    
    convenience init(description: String, options: [String], rightOptionIndex: Int, onSelection: ((viewController: SelectionTestViewController, selectedIndex: Int) -> Void)?) {
        self.init()
        setTestDescription(description)
        self.options = options
        self.rightOptionIndex = rightOptionIndex
        self.onSelection = onSelection
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        descriptionTextView = addTextView()
        tableView = addTableView(heightStyle: .Dynamic(60.0), cellClasses: OptionCell.self)
        
        addConstraints("V:|-16-[textView]-8-[tableView]-0-|", "H:|-8-[textView]-8-|", "H:|-0-[tableView]-0-|")

        navigationItem.title = "假名测试"
        setLeftBarButtonItem("菜单", onClick: onMenuButtonClick)
    }
    
    override func viewWillAppear(animated: Bool) {
        reloadData()
    }
    
    func onMenuButtonClick(sender: AnyObject) {
        slideViewDelegate?.toggleLeftView()
    }
    
    func setTestDescription(description: String) {
        descriptionTextView.text = description
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    var selectedRow: Int = -1
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(optionCellIdentifier, forIndexPath: indexPath) as OptionCell
        cell.setOption(options[indexPath.row])
        if indexPath.row == selectedRow {
            cell.state = indexPath.row == self.rightOptionIndex ? .Right : .Wrong
        } else {
            cell.state = .Normal
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath.row
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            if indexPath.row == self.rightOptionIndex {
                self.selectedRow = -1
                self.onSelection?(viewController: self, selectedIndex: indexPath.row)
                self.tableView.reloadData()
            }
        })
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        CATransaction.commit()
    }
}
