//
//  Meaning.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/24.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation
import CoreData

class Meaning: NSManagedObject {
    
    @NSManaged var word: Word
    @NSManaged var index: Int
    @NSManaged var meaning: String
    @NSManaged var examples: NSOrderedSet

}
