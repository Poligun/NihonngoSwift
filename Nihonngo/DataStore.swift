//
//  DataStore.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/27.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataStore {
    
    struct Instance {
        static var instance: DataStore?
    }
    
    class var sharedInstance: DataStore {
        if Instance.instance == nil {
            Instance.instance = DataStore()
        }
        return Instance.instance!
    }
    
    private var managedObjectContext: NSManagedObjectContext? {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        return appDelegate.managedObjectContext
    }
    
    func saveContext() {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.saveContext()
    }
    
    private lazy var wordFetcher: WordFetcher = {
        let fetcher = WordFetcher()
        return fetcher
    }()
    
    lazy var allWords: [Word] = {
        return self.fetchAllWords()
    }()
    
    func updateAllWords() {
        allWords = fetchAllWords()
    }
    
    func searchWords(searchText: String) -> [Word] {
        var result: [Word] = []
        for word in allWords {
            if word.word.rangeOfString(searchText) != nil || word.kana.rangeOfString(searchText) != nil {
                result.append(word)
            }
        }
        return result
    }
    
    func deleteWord(word: Word) {
        self.managedObjectContext?.deleteObject(word)
        saveContext()
        self.allWords = fetchAllWords()
    }
    
    func deleteType(type: Type) {
        self.managedObjectContext?.deleteObject(type)
        saveContext()
    }
    
    private func fetchAllWords() -> [Word] {
        let request = NSFetchRequest(entityName: "Word")
        var error: NSError?
        request.sortDescriptors = [NSSortDescriptor(key: "kana", ascending: true)]
        return self.managedObjectContext!.executeFetchRequest(request, error: &error)! as [Word]
    }
    
    func hasWord(word: String, kana: String) -> Bool {
        let request = NSFetchRequest(entityName: "Word")
        var error: NSError?
        request.predicate = NSPredicate(format: "word = %@ && kana = %@", word, kana)
        let result = self.managedObjectContext!.executeFetchRequest(request, error: &error)! as [Word]
        return result.count != 0
    }

    func addExample(example: String, withTranslation translation: String, forMeaning meaning: Meaning) {
        let exampleEntity = NSEntityDescription.entityForName("Example", inManagedObjectContext: self.managedObjectContext!)!
        let exampleObject = NSManagedObject(entity: exampleEntity, insertIntoManagedObjectContext: self.managedObjectContext!) as Example
        exampleObject.example = example
        exampleObject.translation = translation
        exampleObject.meaning = meaning
    }
    
    func addWordFromFetched(word: FetchedWord) -> Word {
        let wordEntity = NSEntityDescription.entityForName("Word", inManagedObjectContext: self.managedObjectContext!)!
        let wordObject = NSManagedObject(entity: wordEntity, insertIntoManagedObjectContext: self.managedObjectContext!) as Word
        
        wordObject.word = word.word
        wordObject.kana = word.kana
        
        let typeEntity = NSEntityDescription.entityForName("Type", inManagedObjectContext: self.managedObjectContext!)!
        for type in word.types {
            let typeObject = NSManagedObject(entity: typeEntity, insertIntoManagedObjectContext: self.managedObjectContext!) as Type
            typeObject.type = type.rawValue
            typeObject.word = wordObject
        }
        
        let meaningEntity = NSEntityDescription.entityForName("Meaning", inManagedObjectContext: self.managedObjectContext!)!
        let exampleEntity = NSEntityDescription.entityForName("Example", inManagedObjectContext: self.managedObjectContext!)!
        var meaningCount = 0
        for meaning in word.meanings.componentsSeparatedByString("#") {
            let sentences = meaning.componentsSeparatedByString("*")
            let meaningObject = NSManagedObject(entity: meaningEntity, insertIntoManagedObjectContext: self.managedObjectContext!) as Meaning
            meaningObject.index = meaningCount++
            meaningObject.meaning = sentences[0]
            meaningObject.word = wordObject
            for var i = 1; i < sentences.count; i++ {
                let example = sentences[i].componentsSeparatedByString("$")
                let exampleObject = NSManagedObject(entity: exampleEntity, insertIntoManagedObjectContext: self.managedObjectContext!) as Example
                exampleObject.index = i - 1
                exampleObject.meaning = meaningObject
                if (example.count == 2) {
                    exampleObject.example = example[0]
                    exampleObject.translation = example[1]
                } else {
                    exampleObject.example = example[0]
                    exampleObject.translation = ""
                }
            }
        }
        
        return wordObject
    }

    func insertTestingWords() {
        let testingWords = ["錆びる", "背景", "容貌", "主人", "我が儘", "育つ", "届ける"]
        for newWord in testingWords {
            var error: NSError?
            let request = NSFetchRequest(entityName: "Word")
            request.predicate = NSPredicate(format: "word = %@", newWord)
            if let result = managedObjectContext?.executeFetchRequest(request, error: &error) as? [Word] {
                if result.count > 0 {
                    continue
                }
                wordFetcher.fetchWord(newWord) {(words: [FetchedWord]) -> Void in
                    if (words.count == 0) {
                        return
                    }
                    self.addWordFromFetched(words[0])
                    self.saveContext()
                }
            } else {
                println(error?.description)
            }
        }
    }
    
    func repairExamples() {
        let request = NSFetchRequest(entityName: "Example")
        var error: NSError?
        let examples = self.managedObjectContext?.executeFetchRequest(request, error: &error)! as [Example]
        for example in examples {
            if example.example.rangeOfString("/") != nil {
                println("\(example.example): \(example.translation)")
                let components = example.example.componentsSeparatedByString("/")
                if components.count == 2 {
                    example.example = components[0]
                    example.translation = components[1]
                }
            }
        }
        saveContext()
    }

}
