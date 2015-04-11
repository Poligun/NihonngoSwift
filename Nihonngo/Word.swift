//
//  Word.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/21.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation
import CoreData

class Word: NSManagedObject {

    @NSManaged var word: String
    @NSManaged var kana: String
    @NSManaged var types: NSSet
    @NSManaged var meanings: NSOrderedSet
    
    func stringByJoiningTypes() -> String {
        if types.count == 0 {
            return "无"
        } else {
            return "，".join((types.allObjects as [Type]).map{$0.wordType.rawValue})
        }
    }

}
