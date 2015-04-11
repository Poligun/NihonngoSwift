//
//  MeaningPreviewViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/9.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class MeaningPreviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let labelCellIdentifier = "LabelCell"
    private let examplePreviewCellIdentifier = "ExamplePreviewCell"
    
    private var meaning: Meaning!
    
    private var tableView: UITableView!
    
    convenience init(meaning: Meaning) {
        self.init()
        self.meaning = meaning
    }
    
    override func viewDidLoad() {
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        tableView.registerClass(LabelCell.self, forCellReuseIdentifier: labelCellIdentifier)
        tableView.registerClass(ExamplePreviewCell.self, forCellReuseIdentifier: examplePreviewCellIdentifier)        
        navigationItem.title = "释义预览"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加", style: .Plain, target: self, action: "onAddExampleButtonClick:")
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func onAddExampleButtonClick(sender: AnyObject) {
        let viewController = EditExampleViewController(example: "", translation: "", onSave: {
            (newExample: String, newTranslation: String) -> Void in
            DataStore.sharedInstance.addExample(newExample, withTranslation: newTranslation, forMeaning: self.meaning)
            DataStore.sharedInstance.saveContext()
        })
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // TableView DataSource & Delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "释义" : "例子"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 1
        }
        return section == 0 ? 1 : meaning.examples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(labelCellIdentifier, forIndexPath: indexPath) as LabelCell
            cell.setLabelText(meaning.meaning)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(examplePreviewCellIdentifier, forIndexPath: indexPath) as ExamplePreviewCell
            cell.setExample(meaning.examples[indexPath.row] as Example)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            let viewController = EditMeaningViewController(meaning: meaning.meaning, onSave: {(newMeaning: String) -> Void in
                self.meaning.meaning = newMeaning
                DataStore.sharedInstance.saveContext()
            })
            navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.section == 1 {
            let example = meaning.examples[indexPath.row] as Example
            let viewController = EditExampleViewController(example: example.example, translation: example.translation, onSave: {
                (newExample: String, newTranslation: String) -> Void in
                example.example = newExample
                example.translation = newTranslation
                DataStore.sharedInstance.saveContext()
            })
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}