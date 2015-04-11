//
//  TypeMapping.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/28.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation

class TypeMapping {
    
    struct Instance {
        static var instance: TypeMapping?
    }

    class var sharedInstance: TypeMapping {
        if Instance.instance == nil {
            Instance.instance = TypeMapping()
        }
        return Instance.instance!
    }
    
    let mapping: [String: [WordType]] = [
        "サ変他": [.Sahen, .Transitive],
        "サ変動": [.Sahen],
        "サ変自": [.Sahen, .Intransitive],
        "スル": [.Sahen],
        "五段": [.Godan],
        "一类": [.Godan],
        "一类动词": [.Godan],
        "三类": [.Sahen],
        "下一": [.Ichidan],
        "专": [.Noun],
        "二类": [.Ichidan],
        "人名": [.Noun],
        "他": [.Transitive],
        "他サ": [.Sahen, .Transitive],
        "他サ変": [.Sahen, .Transitive],
        "他五": [.Godan, .Transitive],
        "他动": [.Transitive],
        "他动一类": [.Godan, .Transitive],
        "他动二类": [.Ichidan, .Transitive],
        "他動": [.Transitive],
        "他自動": [.Transitive, .Intransitive],
        "他下一": [.Transitive, .Ichidan],
        "自": [.Intransitive],
        "自サ": [.Sahen, .Intransitive],
        "自サ变": [.Sahen, .Intransitive],
        "自三类": [.Sahen, .Intransitive],
        "自上一": [.Ichidan, .Intransitive],
        "自下一": [.Ichidan, .Intransitive],
        "自五": [.Godan, .Intransitive],
        "自他五": [.Godan, .Intransitive, .Transitive],
        "自他": [.Intransitive, .Transitive],
        "自他动": [.Intransitive, .Transitive],
        "自他動": [.Intransitive, .Transitive],
        "自动": [.Intransitive],
        "自动一类": [.Godan, .Intransitive],
        "自动他": [.Intransitive, .Transitive],
        "自動": [.Intransitive],
        "代": [.Pronoun],
        "副": [.Adverb],
        "助": [.Auxiliary],
        "副助": [.Adverb, .Auxiliary],
        "名": [.Noun],
        "名サ変動": [.Noun, .Sahen],
        "名サ変自": [.Noun, .Sahen, .Intransitive],
        "名詞": [.Noun],
        "名词": [.Noun],
        "名形動": [.Noun, .SecondTypeAdj],
        "名词他动": [.Noun, .Transitive],
        "姓氏": [.Noun],
        "常用口语表达": [.CommonlyUsed],
        "常用惯用语": [.CommonlyUsed],
        "相关惯用语": [.CommonlyUsed],
        "寒暄语": [.CommonlyUsed],
        "形": [.FirstTypeAdj],
        "形动": [.SecondTypeAdj],
        "形動": [.SecondTypeAdj],
        "形動副名": [.SecondTypeAdj, .Adverb, .Noun],
        "感": [.CommonlyUsed],
        "接": [.Conjunction],
        "接助": [.Conjunction],
        "接尾": [.Conjunction],
        "接续": [.Conjunction],
        "日本地名": [.Noun],
        "日本姓氏": [.Noun],
        "连": [.RenTaiShi],
        "连体": [.RenTaiShi],
        "连语": [.RenGo],
        "連体": [.RenTaiShi],
        "連語": [.RenGo],
        "量": [.JyoSuuShi]
    ]
}
