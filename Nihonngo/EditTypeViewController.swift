//
//  EditTypeViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/10.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class EditTypeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    
    private var word: Word!
    
    convenience init(word: Word) {
        self.init()
        self.word = word
    }
    
    enum PickerState {
        case Shown
        case Hidden
    }
    
    var pickerState = PickerState.Hidden
    var pickerPosition: Int = -1
    
    override func viewDidLoad() {
        tableView = addTableView(frame: self.view.bounds, style: .Grouped, heightStyle: .Dynamic(32.0), cellClasses: WordTypeCell.self, TypePickerCell.self)
        
        navigationItem.title = "编辑类型"
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "编辑", style: .Plain, target: self, action: "onEditButtonClick:"),
            UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onAddTypeButtonClick:")
        ]
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func onAddTypeButtonClick(sender: AnyObject) {
        
    }
    
    func onEditButtonClick(sender: UIBarButtonItem) {
        tableView.editing = !tableView.editing
        sender.title = tableView.editing ? "取消" : "编辑"
    }
    
    private func getTypeAtIndex(index: Int) -> Type {
        return word.types.allObjects[index] as Type
    }
    
    func onPickerViewSelect(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerState == .Shown {
            getTypeAtIndex(pickerPosition - 1).wordType = WordType.allValues[row]
            self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: pickerPosition - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "类型"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickerState == .Shown ? word.types.count + 1 : word.types.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if pickerState == .Shown && indexPath.row == pickerPosition {
            let cell = tableView.dequeueReusableCellWithIdentifier(TypePickerCell.defaultReuseIdentifier, forIndexPath: indexPath) as TypePickerCell
            cell.setOnSelectDelegate(self.onPickerViewSelect)
            cell.setSelection(getTypeAtIndex(indexPath.row - 1).wordType)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(WordTypeCell.defaultReuseIdentifier, forIndexPath: indexPath) as WordTypeCell
            let position = pickerState == .Shown && indexPath.row > pickerPosition ? indexPath.row - 1 : indexPath.row
            cell.setWordType(getTypeAtIndex(position).wordType)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if pickerState == .Hidden {
            pickerState = .Shown
            pickerPosition = indexPath.row + 1
            
            UIView.animateWithDuration(0.3, animations: {
                self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.pickerPosition, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
            })
        } else{
            if indexPath.row == pickerPosition - 1 {
                pickerState = .Hidden
                
                UIView.animateWithDuration(0.3, animations: {
                    self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: self.pickerPosition, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
                })
            } else if indexPath.row != pickerPosition {
                pickerPosition = indexPath.row > pickerPosition ? indexPath.row : indexPath.row + 1
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        DataStore.sharedInstance.deleteType(word.types.allObjects[indexPath.row] as Type)
        tableView.reloadData()
    }

}
