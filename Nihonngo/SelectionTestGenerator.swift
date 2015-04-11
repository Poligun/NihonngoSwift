//
//  SelectionTestGenerator.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/11.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import Foundation

class SelectionTestGenerator {
    
    private let kanaOptionGenerator = KanaOptionGenerator()
    
    func generateFromWords(words: [Word]) -> SelectionTest {
        while true {
            let word = words[Int(arc4random()) % words.count]
            if word.meanings.count == 0 {
                continue
            }
            let meaning = word.meanings.array[Int(arc4random()) % word.meanings.count] as Meaning
            if meaning.examples.count == 0 {
                continue
            }
            let example = meaning.examples.array[Int(arc4random()) % meaning.examples.count] as Example
            let selectionTest = SelectionTest(description: example.example)
            
            var options = [word.kana]
            options += kanaOptionGenerator.optionsForWord(word, maxSize: 10, minLength: 0).filter{$0.kana != word.kana}.shuffledCopy()
                .arrayOfFirstNElements(5).map{$0.kana}
            selectionTest.options = options.shuffledCopy()

            for var i = 0; i < selectionTest.options.count; i++ {
                if selectionTest.options[i] == word.kana {
                    selectionTest.rightOptionIndex = i
                    break
                }
            }
            
            return selectionTest
        }
    }

}
