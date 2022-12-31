//
//  SearchViewController.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2022/12/30.
//

import Foundation
import UIKit
class SearchResultTableCell:UITableViewCell{
    static let ID = "SearchResultTableCell"
    var questionTitleView:UILabel!
    var questionContentView:UILabel!
    var questionTimeView:UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        contentView.backgroundColor = .white
        questionTitleView = UILabel()
        questionTitleView.text = "Lorem Ipsum"
        
        questionContentView = UILabel()
        questionContentView.text = "Lorem Ipsum"
        
        questionTimeView = UILabel()
        questionTimeView.text = "Lorem"
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
        questionTimeView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionTimeView)
        contentView.addSubview(questionTitleView)
        contentView.addSubview(questionContentView)
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            questionTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            questionContentView.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor),
            questionContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            questionTimeView.topAnchor.constraint(equalTo: questionContentView.bottomAnchor,constant: 0.0),
            questionTimeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            questionTimeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:-20.0)
        ])
    }
}
class SearchViewController:UIViewController{
    var backButton:UIButton!
    var searchBar:UITextField!
    var searchButton:UIButton!
    var searchResultTable:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setConstraint()
    }
    func setLayout(){
        
        backButton = UIButton()
        backButton.setImage(UIImage(systemName: "arrow.backward"),for:.normal)
        searchBar = UITextField()
        searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchResultTable = UITableView()
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        searchResultTable.register(SearchResultTableCell.self,forCellReuseIdentifier: SearchResultTableCell.ID)
        searchResultTable.separatorStyle = .none
    
        backButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchResultTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        view.addSubview(backButton)
        view.addSubview(searchButton)
        view.addSubview(searchResultTable)
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButton.widthAnchor.constraint(equalTo:backButton.heightAnchor)
        ])
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: backButton.topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: backButton.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: backButton.trailingAnchor)
            
        ])
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchButton.topAnchor),
            searchButton.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchButton.widthAnchor.constraint(equalTo:searchButton.heightAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            searchResultTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResultTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResultTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchResultTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableCell.ID, for: indexPath)
        return cell
    }
    
    
}
