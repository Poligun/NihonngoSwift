//
//  SwipeableCell.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/9.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class SwipeableCell: BaseCell {
    
    var rightButtonWidth: CGFloat = 60.0
    
    var swipeableContentView: UIView!
    
    private var rightButtons = [UIButton]()
    
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    override class var defaultReuseIdentifier: String {
        return "SwipeableCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        swipeableContentView = UIView(frame: CGRectMake(0, 0, 320, 80))
        swipeableContentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        swipeableContentView.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(swipeableContentView)
        
        leadingConstraint = NSLayoutConstraint(item: swipeableContentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        trailingConstraint = NSLayoutConstraint(item: swipeableContentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)

        contentView.addConstraint(leadingConstraint)
        contentView.addConstraint(trailingConstraint)
        contentView.addConstraint(NSLayoutConstraint(item: swipeableContentView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: swipeableContentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0))
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onPanGesture:")
        panGestureRecognizer.cancelsTouchesInView = false
        swipeableContentView.addGestureRecognizer(panGestureRecognizer)

        addButton(title: "Delete", backgroundColor: UIColor.redColor(), action: nil)
    }
    
    func addButton(#title: String, backgroundColor: UIColor = UIColor.clearColor(), action: ((sender: AnyObject) -> Void)?) {
        let button = UIButton()

        button.titleLabel?.text = title
        button.titleLabel?.textColor = UIColor.whiteColor()
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: "", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(button)
        contentView.addConstraints(NSLayoutConstraint.constraints(views: ["swipeable": swipeableContentView, "button": button], formats: "H:[swipeable]-[button(\(rightButtonWidth))]", "V:|-0-[button]-0-|"))
    }
    
    private var panStartingX: CGFloat = 0.0
    
    func onPanGesture(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            panStartingX = recognizer.translationInView(swipeableContentView).x
            println("Starting: \(panStartingX)")
        case .Changed:
            let delta = panStartingX - recognizer.translationInView(swipeableContentView).x as CGFloat
            println("Moved: \(delta)")
            trailingConstraint.constant = recognizer.translationInView(swipeableContentView).x
            recognizer.setTranslation(CGPointZero, inView: swipeableContentView)
        case .Ended:
            let endingX = recognizer.translationInView(swipeableContentView).x
            println("Ending: \(endingX)")
        default:
            break
        }
    }

}
