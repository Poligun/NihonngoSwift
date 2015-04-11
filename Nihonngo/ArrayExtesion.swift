//
//  ArrayExtesion.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/11.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import Foundation

extension Array {
    
    func arrayOfFirstNElements(n: Int) -> [T] {
        var array = [T]()
        let count = min(n, self.count)
        for var i = 0; i < count; i++ {
            array.append(self[i])
        }
        return array
    }

    func shuffledCopy() -> [T] {
        var copy = self
        for var i = 0; i < copy.count; i++ {
            let j = Int(arc4random_uniform(UInt32(copy.count - i))) + i
            swap(&copy[i], &copy[j])
        }
        return copy
    }
}
