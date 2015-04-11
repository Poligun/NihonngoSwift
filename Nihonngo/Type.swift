//
//  Type.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/26.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation
import CoreData

class Type: NSManagedObject {
    
    @NSManaged var word: Word
    @NSManaged var type: String
    
    override var description: String {
        return wordType.rawValue
    }
    
    var wordType: WordType {
        get {
            return WordType(rawValue: self.type)!
        }
        set {
            self.type = newValue.rawValue
        }
    }

}

enum WordType: String {
    case Noun = "名词"
    case Pronoun = "代词"
    case Adverb = "副词"
    case Intransitive = "自动词"
    case Transitive = "他动词"
    case Godan = "五段动词"
    case Ichidan = "一段动词"
    case Sahen = "サ变动词"
    case FirstTypeAdj = "一类形容词"
    case SecondTypeAdj = "二类形容词"
    case Auxiliary = "助词"
    case Conjunction = "接续词"
    case CommonlyUsed = "常用语"
    case RenTaiShi = "连体词"
    case RenGo = "连语"
    case JyoSuuShi = "量词"
    
    static let allValues = [Noun, Pronoun, Adverb, Intransitive, Transitive, Godan, Ichidan, Sahen, FirstTypeAdj, SecondTypeAdj]
}