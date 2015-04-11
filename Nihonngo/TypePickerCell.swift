//
//  TypePickerCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/2.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class TypePickerCell: BaseCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let pickerView = UIPickerView()
    private var delegateFunc: ((pickerView: UIPickerView, row: Int, component: Int) -> Void)?
    
    override class var defaultReuseIdentifier: String {
        return "TypePickerCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        pickerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        pickerView.dataSource = self
        pickerView.delegate = self
        self.contentView.addSubview(pickerView)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(
            views: ["pickerView": pickerView],
            formats: "V:|-0-[pickerView]-0-|",
                     "H:|-0-[pickerView]-0-|"))
    }
    
    func setOnSelectDelegate(delegateFunc: (pickerView: UIPickerView, row: Int, component: Int) -> Void) {
        self.delegateFunc = delegateFunc
    }
    
    func setSelection(wordType: WordType) {
        for var i = 0; i < WordType.allValues.count; i++ {
            if WordType.allValues[i] == wordType {
                pickerView.selectRow(i, inComponent: 0, animated: false)
            }
        }
    }

    // PickerView DataSource & Delegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return WordType.allValues.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel()
            label!.textAlignment = NSTextAlignment.Center
            label!.font = UIFont.systemFontOfSize(13.0)
        }
        label!.text = WordType.allValues[row].rawValue
        return label!
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegateFunc?(pickerView: pickerView, row: row, component: component)
    }
    
}
