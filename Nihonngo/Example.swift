//
//  Example.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/26.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation
import CoreData

class Example: NSManagedObject {
    
    @NSManaged var index: Int
    @NSManaged var example: String
    @NSManaged var translation: String
    @NSManaged var meaning: Meaning

}
