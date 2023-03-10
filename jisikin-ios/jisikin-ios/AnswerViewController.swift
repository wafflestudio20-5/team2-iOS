//
//  AnswerViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit
import RxSwift
let BLUE_COLOR = UIColor(red: 111/255.0, green:200/255.0, blue: 240/255.0, alpha: 1.0)

           
class AnswerViewController: UIViewController {
    
    var loading = false
    var bag = DisposeBag()
    var titleView:UILabel!
    var searchButton:UIButton!
    var sortMethodSegment:PlainSegmentedControl!
    var questionTable:UITableView!
    var viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setBackButton()
        setLayout()
        setConstraint()
        // Do any additional setup after loading the view.
        viewModel.questions.asObservable().bind(to:questionTable.rx.items(cellIdentifier: QuestionTableViewCell.ID)){index,model,cell in
            (cell as! QuestionTableViewCell).configure(question:model)

            self.loading = false
 
        }.disposed(by: bag)
        viewModel.getQuestionsByDate()
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.questionTable.deselectSelectedRow(animated: false)
        if let sortMethodSegment{
            if sortMethodSegment.selectedSegmentIndex == 0{
                viewModel.getQuestionsByDate()
            }
            else{
                viewModel.getQuestionsByLikes()
            }
        }
    }
    func setBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(named: "MainColor")
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    func setLayout(){
        navigationController?.isNavigationBarHidden = false
        title = "답변하기"
        
        navigationItem.setRightBarButton(UIBarButtonItem(image:UIImage(systemName:"magnifyingglass")!.withTintColor(.black, renderingMode: .alwaysOriginal) , style: .plain, target: self, action: #selector(onSearchButtonPressed)), animated: true)
        
        
        sortMethodSegment = PlainSegmentedControl(items:["최신순","좋아요순"])
        sortMethodSegment.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        sortMethodSegment.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor(red: 129/255.0, green: 129/255.0, blue: 129/255.0, alpha: 1),
                .font: UIFont.systemFont(ofSize: 15, weight:.regular)
            ],
            for: .normal
          )
        sortMethodSegment.setTitleTextAttributes(
            [
              NSAttributedString.Key.foregroundColor: BLUE_COLOR,
              .font: UIFont.systemFont(ofSize: 15, weight: .bold)
            ],
            for: .selected
          )
        sortMethodSegment.backgroundColor = .systemGray6
        sortMethodSegment.addTarget(self, action: #selector(onSegmentValueChanged(segment:)), for: .valueChanged)
        sortMethodSegment.selectedSegmentIndex = 0
        questionTable = UITableView()
        questionTable.delegate = self
        
        questionTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        questionTable.register(QuestionTableViewCell.self,forCellReuseIdentifier: QuestionTableViewCell.ID)
        questionTable.refreshControl = UIRefreshControl()
        questionTable.refreshControl?.addTarget(self, action: #selector(onQuestionRefresh), for: .valueChanged)
        
        
        
        sortMethodSegment.translatesAutoresizingMaskIntoConstraints = false
        questionTable.translatesAutoresizingMaskIntoConstraints = false
        
       
        view.addSubview(sortMethodSegment)
        view.addSubview(questionTable)
        
        
    }
    func setConstraint(){
       
        NSLayoutConstraint.activate([
            sortMethodSegment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40.0),
            sortMethodSegment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-40.0),
            sortMethodSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10.0),
            sortMethodSegment.heightAnchor.constraint(equalToConstant: 45.0)
        ])
        NSLayoutConstraint.activate([
            questionTable.topAnchor.constraint(equalTo: sortMethodSegment.bottomAnchor,constant:10.0),
            questionTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            questionTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            questionTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    @objc func onSearchButtonPressed(){
        navigationController?.pushViewController(SearchViewController(), animated: false)
    }
    @objc func onSegmentValueChanged(segment:UISegmentedControl){
        if segment.selectedSegmentIndex == 0{
            viewModel.getQuestionsByDate()
        }
        else{
            viewModel.getQuestionsByLikes()
        }
    }
    @objc func onQuestionRefresh(){
        if sortMethodSegment.selectedSegmentIndex == 0{
            viewModel.getQuestionsByDate()
        }
        else{
            viewModel.getQuestionsByLikes()
        }
        self.questionTable?.refreshControl?.endRefreshing()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AnswerViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = QuestionDetailViewModel(usecase: viewModel.usecase, questionID: viewModel.questions.value[indexPath.row].questionId)
        detailViewModel.refresh()
        navigationController?.pushViewController(QuestionDetailViewController(viewModel: detailViewModel), animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 3 && !loading {
            loading = true
            if sortMethodSegment.selectedSegmentIndex == 0{
                viewModel.getMoreQuestionsByDate()
            }
            else{
                viewModel.getMoreQuestionsByLikes()
            }
        }
    }
    
}
extension UITableView {

    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }

}
