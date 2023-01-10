//
//  SearchViewController.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2022/12/30.
//

import Foundation
import UIKit

class SearchViewController:UIViewController{
    
    var searchResultTable:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setConstraint()
    }
    func setLayout(){
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = UISearchBar()
        searchResultTable = UITableView()
        searchResultTable.delegate = self
        searchResultTable.dataSource = self
        searchResultTable.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.ID)
        searchResultTable.separatorStyle = .none
        searchResultTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchResultTable)
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            searchResultTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResultTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResultTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.ID, for: indexPath) as! QuestionTableViewCell
       
        return cell
    }
    
    
}
