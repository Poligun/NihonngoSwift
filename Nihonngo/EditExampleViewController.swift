//
//  EditExampleViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/9.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class EditExampleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let textViewCellIdentifier = "TextViewCell"
    
    private var tableView: UITableView!
    private var example: String!
    private var translation: String!
    
    private var onSaveFunc: ((newExample: String, newTranslation: String) -> Void)?
    
    convenience init(example: String, translation: String, onSave: ((newExample: String, newTranslation: String) -> Void)?) {
        self.init()
        self.example = example
        self.translation = translation
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
        
        navigationItem.title = "编辑例子"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: "onSaveButtonClick:")
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func onSaveButtonClick(sender: AnyObject) {
        view.endEditing(false)
        onSaveFunc?(newExample: example, newTranslation: translation)
        navigationController?.popViewControllerAnimated(true)
    }
    
    // TableView DataSource & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "例子" : "翻译"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textViewCellIdentifier, forIndexPath: indexPath) as TextViewCell
        if indexPath.section == 0 {
            cell.setText(example, onEndEditing: {(textView: UITextView) -> Void in
                self.example = textView.text
            })
        } else {
            cell.setText(translation, onEndEditing: {(textView: UITextView) -> Void in
                self.translation = textView.text
            })
        }
        return cell
    }

}
