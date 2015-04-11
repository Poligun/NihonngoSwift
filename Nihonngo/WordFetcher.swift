//
//  WordFetcher.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 14/12/21.
//  Copyright (c) 2014年 ZhaoYuhan. All rights reserved.
//

import Foundation

struct FetchedWord {
    let word: String
    let kana: String
    let types: [WordType]
    let meanings: String
}

class WordFetcher {
    
    func fetchWord(word: String, wordHandler: (words: [FetchedWord]) -> Void) {
        let escaped = word.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let url = NSURL(string: "http://dict.hjenglish.com/jp/jc/\(escaped)")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            if error == nil {
                println("Server responded. Parsing data...")
                self.parseData(NSString(data: data, encoding: NSUTF8StringEncoding)!, wordHandler: wordHandler)
            } else {
                wordHandler(words: [])
                println(error)
            }
        }
        
        println("Fetching word: \(word)")
        NSURLSession.sharedSession().configuration.timeoutIntervalForRequest = 10.0
        task.resume()
    }
    
    private func parseHtml() {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url = urls[urls.count - 1] as NSURL
        let content = NSString(data: NSData(contentsOfURL: url.URLByAppendingPathComponent("fetch.html"))!, encoding: NSUTF8StringEncoding)!
    }
    
    private func parseData(data: NSString, wordHandler: (words: [FetchedWord]) -> Void) {
        var words: [FetchedWord] = []
        for var i = 0; true; i++ {
            let wordRange = data.rangeOfString("<span id=\"jpword_\(i)\"")
            let kanaRange = data.rangeOfString("<span id=\"kana_\(i)\"")
            let commentRange = data.rangeOfString("<span id=\"comment_\(i)\"")
            
            if wordRange.location == NSNotFound {
                break
            }

            let word = getTextOfElement(data, tag: "span", startLocation: wordRange.location)
            let kana = removeParentheses(filterContent(getTextOfElement(data, tag: "span", startLocation: kanaRange.location)))
            let comment = getTextOfElement(data, tag: "span", startLocation: commentRange.location)
            
            let typeRange = comment.rangeOfString("<p class=\"wordtype\">")
            let types = getTypes(comment)
            
            var meanings: String = ""
            for component in filterComment(filterContent(comment)).componentsSeparatedByString("<br/>") {
                if component.isEqualToString("") {
                    continue
                }
                let converted = convertPunctuations(component as NSString)
                if converted.rangeOfString("　 ").location != NSNotFound {
                    meanings += "*" + converted.stringByReplacingOccurrencesOfString("　 ", withString: "").stringByReplacingOccurrencesOfString("／", withString: "$")
                } else {
                    if meanings != "" {
                        meanings += "#"
                    }
                    meanings += removeParentheses(converted)
                }
            }
            words.append(FetchedWord(word: word, kana: kana, types: types, meanings: meanings))
        }
        wordHandler(words: words)
    }
    
    private func getTextOfElement(html: NSString, tag: String, startLocation: Int) -> NSString {
        let lRange = html.rangeOfString(">", options: .LiteralSearch, range: NSRange(location: startLocation, length: html.length - startLocation))
        if lRange.location != NSNotFound {
            let rRange = html.rangeOfString("</\(tag)>", options: .LiteralSearch, range: NSRange(location: lRange.location, length: html.length - lRange.location))
            if rRange.location != NSNotFound {
                return html.substringWithRange(NSRange(location: lRange.location + 1, length: rRange.location - lRange.location - 1))
            }
        }
        return ""
    }
    
    private func getTypes(comment: NSString) -> [WordType] {
        var types = [WordType]()
        let results = NSRegularExpression(pattern: "【[^】]+】", options: nil, error: nil)!.matchesInString(comment, options: .allZeros, range: NSRange(location: 0, length: comment.length))

        for result in results {
            let rawType = removeParentheses(comment.substringWithRange(result.range))
            let parsedTypes = NSRegularExpression(pattern: "[•・·･▪，.【】]", options: nil, error: nil)!
                .stringByReplacingMatchesInString(rawType, options: .allZeros, range: NSRange(location: 0, length: rawType.length), withTemplate: "#")
                .componentsSeparatedByString("#")
            
            for type in parsedTypes {
                if let t = TypeMapping.sharedInstance.mapping[type] {
                    types += t
                } else {
                    println("Type mapping not found: \(type)")
                }
            }
        }
        
        types.sort{$0.rawValue < $1.rawValue}
        
        return types
    }
    
    private func filterContent(content: NSString) -> NSString {
        let regex = NSRegularExpression(pattern: "<img[^>]+/>|<font[^>]+>|</font>", options: nil, error: nil)!
        let _content =
            content.stringByReplacingOccurrencesOfString("\n", withString: "")
                   .stringByReplacingOccurrencesOfString("\r", withString: "") as NSString
        return regex.stringByReplacingMatchesInString(_content, options: .allZeros, range: NSRange(location: 0, length: _content.length), withTemplate: "")
    }
    
    private func filterComment(comment: NSString) -> NSString {
        return NSRegularExpression(pattern: "<p[^>]+>|</p>|【[^】]+】", options: nil, error: nil)!
            .stringByReplacingMatchesInString(comment, options: .allZeros, range: NSRange(location: 0, length: comment.length), withTemplate: "")
    }
    
    private func removeParentheses(original: NSString) -> NSString {
        let regex = NSRegularExpression(pattern: "【|】|（[0-9]+）", options: nil, error: nil)!
        return regex.stringByReplacingMatchesInString(original, options: .allZeros, range: NSRange(location: 0, length: original.length), withTemplate: "")
    }
    
    private func convertPunctuations(original: NSString) -> NSString {
        var converted = original
        for (key, value) in punctuationDict {
            converted = converted.stringByReplacingOccurrencesOfString(key, withString: value)
        }
        return converted
    }
    
    private let punctuationDict: [String: String] = [
        ";" : "；",
        "." : "。",
        "," : "，",
        "(" : "（",
        ")" : "）",
        "/" : "／"
    ]

}
