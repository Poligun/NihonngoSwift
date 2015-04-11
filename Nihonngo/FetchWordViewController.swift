//
//  FetchWordViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/10.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class FetchWordViewController: BaseViewController, UISearchBarDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    
    private var fetchedWords = [FetchedWord]()
    private var exists = [Bool]()
    
    enum FetchingState {
        case Normal
        case Fetching
        case NoResult
    }
    
    private var pendingSearchText: String?

    private var fetchingState = FetchingState.Normal
    
    private lazy var wordFetcher: WordFetcher = {
        let fetcher = WordFetcher()
        return fetcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "在线查询"

        searchBar = addSearchBar(placeHolder: "输入待查单词或假名")
        tableView = addTableView(heightStyle: .Dynamic(60.0), cellClasses: FetchedWordCell.self, LoadingCell.self, LabelCell.self)
        
        addConstraints("V:|-0-[searchBar]-0-[tableView]-0-|", "H:|-0-[searchBar]-0-|", "H:|-0-[tableView]-0-|")
    }

    override func viewWillAppear(animated: Bool) {
        if let searchText = pendingSearchText {
            searchBar.text = searchText
            searchBar.becomeFirstResponder()
            pendingSearchText = nil
        } else {
            searchBar.resignFirstResponder()
        }
        for var i = 0; i < fetchedWords.count; i++ {
            exists[i] = DataStore.sharedInstance.hasWord(fetchedWords[i].word, kana: fetchedWords[i].kana)
        }
        tableView.reloadData()
    }
    
    func setSearchText(searchText: String) {
        pendingSearchText = searchText
    }

    
    // SearchBar Delegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if fetchingState != .Fetching {
            fetchingState = .Fetching
            wordFetcher.fetchWord(searchBar.text, wordHandler: {(words: [FetchedWord]) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    self.fetchedWords = words
                    self.fetchingState = words.count == 0 ? .NoResult : .Normal
                    self.exists.removeAll(keepCapacity: true)
                    for word in words {
                        self.exists.append(DataStore.sharedInstance.hasWord(word.word, kana: word.kana))
                    }
                    self.tableView.reloadData()
                })
            })
            tableView.reloadData()
        }
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    // TableView DataSource & Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch fetchingState {
        case .Normal:
            return fetchedWords.count
        case .Fetching:
            return 1
        case .NoResult:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch fetchingState {
        case .Normal:
            let cell = tableView.dequeueReusableCellWithIdentifier(FetchedWordCell.defaultReuseIdentifier, forIndexPath: indexPath) as FetchedWordCell
            cell.setFetchedWord(fetchedWords[indexPath.row])
            cell.setState(exists[indexPath.row] ? "单词已存在" : "")
            return cell
        case .Fetching:
            let cell = tableView.dequeueReusableCellWithIdentifier(LoadingCell.defaultReuseIdentifier, forIndexPath: indexPath) as LoadingCell
            cell.setLoadingText("在线查询中", animating: true)
            return cell
        case .NoResult:
            let cell = tableView.dequeueReusableCellWithIdentifier(LabelCell.defaultReuseIdentifier, forIndexPath: indexPath) as LabelCell
            cell.setLabelText("未找到相关的词条", textAlignment: .Center)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if fetchingState == .Normal {
            let alertView = UIAlertView(title: "确认添加单词（\(fetchedWords[indexPath.row].word)）吗",
                message: "单词将被加入离线词库", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
            alertView.tag = indexPath.row
            alertView.show()
        }
    }
    
    // AlertView Delegate
    
    func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            let wordViewController = WordViewController()
            
            wordViewController.word = DataStore.sharedInstance.addWordFromFetched(fetchedWords[alertView.tag])
            DataStore.sharedInstance.saveContext()
            DataStore.sharedInstance.updateAllWords()

            searchBar.text = ""
            searchBar.resignFirstResponder()
            
            navigationController?.pushViewController(wordViewController, animated: true)
        }
    }

}
