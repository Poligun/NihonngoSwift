//
//  WordViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/31.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import UIKit

class WordViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let meaningCellIdentifier = "MeaningCell"
    private let exampleCellIdentifier = "ExampleCell"
    
    private let wordLabel = UILabel()
    private let kanaLabel = UILabel()
    private let typesLabel = UILabel()
    private let tableView = UITableView()
    
    private var entries = [AnyObject]()
    
    weak var word: Word? {
        didSet {
            if word != nil {
                entries.removeAll(keepCapacity: false)
                for meaning in word!.meanings.array as [Meaning] {
                    entries.append(meaning)
                    for example in meaning.examples.array as [Example] {
                        entries.append(example)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        wordLabel.font = UIFont.systemFontOfSize(19.0)
        typesLabel.textColor = UIColor.blackColor()
        self.view.addSubview(wordLabel)

        kanaLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        kanaLabel.font = UIFont.systemFontOfSize(15.0)
        kanaLabel.textColor = UIColor.lightGrayColor()
        self.view.addSubview(kanaLabel)

        typesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        typesLabel.font = UIFont.systemFontOfSize(15.0)
        typesLabel.textColor = UIColor.blackColor()
        self.view.addSubview(typesLabel)
        
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.estimatedRowHeight = 32.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(
            views: ["wordLabel": wordLabel, "kanaLabel": kanaLabel, "typesLabel": typesLabel, "tableView": tableView],
            formats: "V:|-8-[wordLabel]-8-[kanaLabel]-16-[tableView]-0-|",
                     "V:|-16-[typesLabel]",
                     "H:|-8-[wordLabel]",
                     "H:|-8-[kanaLabel]",
                     "H:[typesLabel]-15-|",
                     "H:|-0-[tableView]-0-|"))

        navigationItem.title = "单词详情"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .Plain, target: self, action: "onEditButtonClick:")

        tableView.registerClass(MeaningCell.self, forCellReuseIdentifier: meaningCellIdentifier)
        tableView.registerClass(ExampleCell.self, forCellReuseIdentifier: exampleCellIdentifier)
    }
    
    override func viewWillAppear(animated: Bool) {
        if word == nil {
            self.wordLabel.text = ""
            self.kanaLabel.text = ""
            navigationController?.popViewControllerAnimated(true)
        } else {
            self.wordLabel.text = self.word!.word
            self.kanaLabel.text = self.word!.kana
            self.typesLabel.text = self.word!.stringByJoiningTypes()
            tableView.reloadData()
        }
    }

    func onEditButtonClick(sender: AnyObject) {
        let viewController = EditWordViewController(editingWord: self.word!, onDelete: { () -> Void in
            self.word = nil
        })
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word == nil ? 0 : entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if entries[indexPath.row] is Meaning {
            let cell = tableView.dequeueReusableCellWithIdentifier(meaningCellIdentifier, forIndexPath: indexPath) as MeaningCell
            cell.setMeaning(entries[indexPath.row] as Meaning)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(exampleCellIdentifier, forIndexPath: indexPath) as ExampleCell
            cell.setExample(entries[indexPath.row] as Example)
            return cell
        }
    }
}
