//
//  EditWordViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/1.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class EditWordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate {
    
    private let editCellIdentifier = "EditCell"
    private let labelCellIdentifier = "LabelCellIdentifier"
    private let meaningPreviewCellIdentifier = "MeaningPreviewCell"
    
    private var tableView: UITableView!
    
    private var onDeleteFunc: (() -> Void)?

    private var editingWord: Word!
    
    private var types: [WordType] = []
    
    convenience init(editingWord: Word, onDelete: (() -> Void)?) {
        self.init()
        self.editingWord = editingWord
        for type in editingWord.types.allObjects as [Type] {
            types.append(type.wordType)
        }
        self.onDeleteFunc = onDelete
    }

    override func viewDidLoad() {
        tableView = UITableView(frame: self.view.bounds, style: .Grouped)
        tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)

        let recognizer = UITapGestureRecognizer(target: self, action: "endEditing")
        recognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(recognizer)

        tableView.registerClass(EditCell.self, forCellReuseIdentifier: editCellIdentifier)
        tableView.registerClass(LabelCell.self, forCellReuseIdentifier: labelCellIdentifier)
        tableView.registerClass(MeaningPreviewCell.self, forCellReuseIdentifier: meaningPreviewCellIdentifier)

        navigationItem.title = "编辑单词"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "删除", style: .Plain, target: self, action: "onDeleteButtonClick:")
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        endEditing()
    }
    
    func endEditing() {
        self.view.endEditing(false)
    }

    func onDeleteButtonClick(sender: AnyObject) {
        UIAlertView(title: "确认删除该单词吗", message: "一旦删除将不可恢复。", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认").show()
    }
    
    // AlertView Delegate
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            DataStore.sharedInstance.deleteWord(editingWord)
            onDeleteFunc?()
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // TextField Delegate for Word & Kana
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 0 {
            editingWord.word = textField.text
        } else if textField.tag == 1 {
            editingWord.kana = textField.text
        }
        DataStore.sharedInstance.saveContext()
    }
    
    // TableView DataSource & Delegate
    
    let sectionHeaders = ["拼写", "类型", "释义"]

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionHeaders.count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return editingWord.meanings.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        return "删除"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(editCellIdentifier, forIndexPath: indexPath) as EditCell
            if (indexPath.row == 0) {
                cell.setAll(label: "单词", textField: self.editingWord.word, fieldTag: 0, delegate: self)
            } else {
                cell.setAll(label: "假名", textField: self.editingWord.kana, fieldTag: 1, delegate: self)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(labelCellIdentifier, forIndexPath: indexPath) as LabelCell
            cell.setLabelText(editingWord.stringByJoiningTypes(), textAlignment: .Center)
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(meaningPreviewCellIdentifier, forIndexPath: indexPath) as MeaningPreviewCell
            cell.setMeaning(editingWord.meanings[indexPath.row] as Meaning)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            let viewController = EditTypeViewController(word: editingWord)
            self.navigationController?.pushViewController(viewController, animated: true)
        case 2:
            let viewController = MeaningPreviewViewController(meaning: editingWord.meanings[indexPath.row] as Meaning)
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}

