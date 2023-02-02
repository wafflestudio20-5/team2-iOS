//
//  HeartedQViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/30.
//

import UIKit
import RxSwift

class HeartedQViewController: UIViewController {
    var loading = false
    
    var bag = DisposeBag()
    var questionTable:UITableView!
    var viewModel = MyRelatedQuestionListViewModel(usecase:MyRelatedQuestionUsecase())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        navigationItem.title = "좋아요 누른 질문"
        
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
        viewModel.getMyHeartedQuestions()
        
        view.addSubview(questionTable)
        
        questionTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),    
            questionTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            questionTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            questionTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        // Do any additional setup after loading the view.
    }
    @objc func onQuestionRefresh(){
        viewModel.getMyHeartedQuestions()
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
extension HeartedQViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewModel = QuestionDetailViewModel(usecase: QuestionAnswerUsecase(), questionID: viewModel.questions.value[indexPath.row].id)
        detailViewModel.refresh()
        navigationController?.pushViewController(QuestionDetailViewController(viewModel: detailViewModel), animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 3 && !loading {
            loading = true
            viewModel.getMoreMyHeartedQuestions()
        }
    }
}
