//
//  EditMeaningViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/8.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class EditMeaningViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let textViewCellIdentifier = "TextViewCell"

    private var tableView: UITableView!
    private var meaning: String!
    
    private var onSaveFunc: ((newMeaning: String) -> Void)?
    
    convenience init(meaning: String, onSave: ((newMeaning: String) -> Void)?) {
        self.init()
        self.meaning = meaning
        self.onSaveFunc = onSave
    }
    
    override func viewDidLoad() {
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.rowHeight = 120.0
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        tableView.registerClass(TextViewCell.self, forCellReuseIdentifier: textViewCellIdentifier)
        
        navigationItem.title = "编辑释义"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: "onSaveButtonClick:")
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func onSaveButtonClick(sender: AnyObject) {
        view.endEditing(false)
        onSaveFunc?(newMeaning: meaning)
        navigationController?.popViewControllerAnimated(true)
    }
    
    // TableView DataSource & Delegate
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "释义"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textViewCellIdentifier, forIndexPath: indexPath) as TextViewCell
        cell.setText(meaning, onEndEditing: {(textView: UITextView) -> Void in
            self.meaning = textView.text
        })
        return cell
    }

}
