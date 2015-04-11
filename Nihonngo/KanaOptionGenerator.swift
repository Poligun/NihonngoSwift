//
//  KanaOptionGenerator.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/11.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import Foundation

class KanaOptionGenerator {

    struct Option {
        var word: String!
        var kana: String!
        var lcsLength: Int!
    }
    
    func optionsForWord(word: Word, maxSize: Int = 0, minLength: Int = 0) -> [Option] {
        var options = [Option]()
        for otherWord in DataStore.sharedInstance.allWords {
            if otherWord == word {
                continue
            }
            let option = Option(word: otherWord.word, kana: otherWord.kana, lcsLength: word.kana.longestCommonSequenceLength(otherWord.kana))
            if option.lcsLength >= minLength {
                options.append(option)
            }
        }

        options.sort({(this, that) -> Bool in
            return this.lcsLength > that.lcsLength
        })

        if maxSize == 0 || maxSize > options.count {
            return options
        } else {
            return options.arrayOfFirstNElements(maxSize)
        }
    }
}
