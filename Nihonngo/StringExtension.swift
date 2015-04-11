//
//  StringExtension.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/11.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import Foundation

extension String {
    func longestCommonSequenceLength(another: String) -> Int {
        let this = Array(self)
        let that = Array(another)
        var f = Array(count: this.count + 1, repeatedValue: Array(count: that.count + 1, repeatedValue: 0))
        var maxF = 0

        for var i = 1; i <= this.count; i++ {
            for var j = 1; j <= that.count; j++ {
                if this[i - 1] == that[j - 1] {
                    f[i][j] = f[i - 1][j - 1] + 1
                } else {
                    f[i][j] = max(f[i - 1][j], f[i][j - 1])
                }
                
                if f[i][j] > maxF {
                    maxF = f[i][j]
                }
            }
        }

        return maxF
    }
}
