//
//  WordListViewController.swift
//  Nihonngo
//
//  Created by ZhaoYuhan on 15/1/6.
//  Copyright (c) 2015年 ZhaoYuhan. All rights reserved.
//

import UIKit

class WordListViewController: BaseViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private var searchBar: UISearchBar!
    private var tableView: UITableView!

    private var words: [Word]!
    
    var slideViewDelegate: SlideViewDelegate?
    
    private lazy var wordViewController: WordViewController = {
        let wordViewController = WordViewController()
        return wordViewController
    }()
    
    private lazy var fetchWordViewController: FetchWordViewController = {
        let fetchWordViewController = FetchWordViewController()
        return fetchWordViewController
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "单词列表"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: .Plain, target: self, action: "onMenuButtonClick:")
        addRightBarButtonItem("在线查询", onClick: onAddButtonClick)

        searchBar = addSearchBar(placeHolder: "输入待查单词或假名")
        tableView = addTableView(heightStyle: .Fixed(44.0), cellClasses: WordCell.self)
        
        addConstraints("V:|-0-[searchBar]-0-[tableView]-0-|", "H:|-0-[searchBar]-0-|", "H:|-0-[tableView]-0-|")
    }
    
    private func updateWords() {
        words = searchBar.text == "" ? DataStore.sharedInstance.allWords : DataStore.sharedInstance.searchWords(searchBar.text)
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        updateWords()
    }

    func onMenuButtonClick(sender: AnyObject) {
        slideViewDelegate?.toggleLeftView()
    }
    
    func onAddButtonClick(sender: AnyObject) {
        if searchBar.text != "" {
            fetchWordViewController.setSearchText(searchBar.text)
        }
        navigationController?.pushViewController(fetchWordViewController, animated: true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        updateWords()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        updateWords()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        onAddButtonClick(searchBar)
    }
    
    // TableView DataSource & Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(WordCell.defaultReuseIdentifier, forIndexPath: indexPath) as WordCell
        cell.setWord(words[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        wordViewController.word = words[indexPath.row]
        navigationController?.pushViewController(wordViewController, animated: true)
    }
}
