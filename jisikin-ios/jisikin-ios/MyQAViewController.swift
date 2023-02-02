//
//  MyQAViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/30.
//

import UIKit
import RxSwift

class MyQAViewController: UIViewController{
    var loading = false
    
    var bag = DisposeBag()
    var segmentedControl: PlainSegmentedControl!
    var questionTable:UITableView!
    var viewModel = MyRelatedQuestionListViewModel(usecase:MyRelatedQuestionUsecase())
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if(UserDefaults.standard.bool(forKey: "isLogin")){
            self.questionTable.deselectSelectedRow(animated: false)
            if let segmentedControl{
                if segmentedControl.selectedSegmentIndex == 0{
                    viewModel.getMyQuestions()
                }
                else{
                    viewModel.getMyAnsweredQuestions()
                }
            }
        }
        
        else{
            navigationController?.popViewController(animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        navigationItem.title = "나의 Q&A"
        
        segmentedControl = PlainSegmentedControl(items: ["질문", "답변"])
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        segmentedControl.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        segmentedControl.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor(red: 129/255.0, green: 129/255.0, blue: 129/255.0, alpha: 1),
                .font: UIFont.systemFont(ofSize: 20, weight:.regular)
            ],
            for: .normal
          )
        segmentedControl.setTitleTextAttributes(
            [
              NSAttributedString.Key.foregroundColor: BLUE_COLOR,
              .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ],
            for: .selected
          )
        segmentedControl.backgroundColor = .systemGray6
        
        questionTable = UITableView()
        questionTable.delegate = self
        
        questionTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        questionTable.register(MyRelatedQuestionTableViewCell.self,forCellReuseIdentifier: MyRelatedQuestionTableViewCell.ID)
        questionTable.refreshControl = UIRefreshControl()
        questionTable.refreshControl?.addTarget(self, action: #selector(onQuestionRefresh), for: .valueChanged)
        
        viewModel.questions.asObservable().bind(to:questionTable.rx.items(cellIdentifier: MyRelatedQuestionTableViewCell.ID)){index,model,cell in
            (cell as! MyRelatedQuestionTableViewCell).configure(question:model)
            //self.questionTable?.refreshControl?.endRefreshing()
        }.disposed(by: bag)
        viewModel.getMyQuestions()
        
        view.addSubview(segmentedControl)
        view.addSubview(questionTable)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        questionTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40.0),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-40.0),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10.0),
            segmentedControl.heightAnchor.constraint(equalToConstant: 45.0),
            
            questionTable.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            questionTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            questionTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            questionTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        // Do any additional setup after loading the view.
    }
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0){
            viewModel.getMyQuestions()
        }
        else if (sender.selectedSegmentIndex == 1){
            viewModel.getMyAnsweredQuestions()
        }
    }
    @objc func onQuestionRefresh(){
        if segmentedControl.selectedSegmentIndex == 0{
            viewModel.getMyQuestions()
        }
        else{
            viewModel.getMyAnsweredQuestions()
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
extension MyQAViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = QuestionDetailViewModel(usecase: QuestionAnswerUsecase(), questionID: viewModel.questions.value[indexPath.row].id)
        detailViewModel.refresh()
        navigationController?.pushViewController(QuestionDetailViewController(viewModel: detailViewModel), animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 3 && !loading {
            loading = true
            if segmentedControl.selectedSegmentIndex == 0{
                viewModel.getMoreMyQuestions()
            }
            else{
                viewModel.getMoreMyAnsweredQuestions()
            }
        }
    }
}

