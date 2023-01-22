//
//  SearchViewController.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2022/12/30.
//

import Foundation
import UIKit
import RxSwift

class SearchViewController:UIViewController{
    var bag = DisposeBag()
    var viewModel = QuestionListViewModel(usecase: QuestionAnswerUsecase())
    let searchBar = UISearchBar()
    let searchButton = UIButton()
    var searchResultTable:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        binding()
        setConstraint()
    }
    func setLayout(){
        searchBar.delegate = self
        navigationController?.isNavigationBarHidden = false
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        searchButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        searchButton.setTitle("search", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
        
        searchResultTable = UITableView()
        searchResultTable.delegate = self
        searchResultTable.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.ID)
        searchResultTable.separatorStyle = .none
        searchResultTable.keyboardDismissMode = .onDrag
        searchResultTable.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        view.addSubview(searchResultTable)
    }
    func binding(){
        viewModel.questions.asObservable().bind(to:searchResultTable.rx.items(cellIdentifier: QuestionTableViewCell.ID)){index,model,cell in
            (cell as! QuestionTableViewCell).configure(question:model)
        }.disposed(by: bag)
    }
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            searchResultTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResultTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResultTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc
    func onTapButton() {
        viewModel.searchQuestions(keyword: searchBar.text!)
        dismissKeyboard()
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

extension SearchViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(QuestionDetailViewController(viewModel: QuestionDetailViewModel(usecase: viewModel.usecase, questionID: viewModel.questions.value[indexPath.row].questionId)), animated: true)
    }
    
    
}
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchQuestions(keyword: searchBar.text!)
        dismissKeyboard()
    }
}
