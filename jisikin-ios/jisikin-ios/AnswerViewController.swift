//
//  AnswerViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

let BLUE_COLOR = UIColor(red: 111/255.0, green:200/255.0, blue: 240/255.0, alpha: 1.0)

           
class AnswerViewController: UIViewController {
    
   
    
    var titleView:UILabel!
    var searchButton:UIButton!
    var sortMethodSegment:PlainSegmentedControl!
    var questionTable:UITableView!
    var viewModel = QuestionListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setLayout()
        setConstraint()
        // Do any additional setup after loading the view.
        viewModel.onQuestionListChanged  = {[weak self]
            questions in
            self?.questionTable.reloadData()
        }
        viewModel.getRecentQuestions()
    }
    func setLayout(){
        navigationController?.isNavigationBarHidden = false
        title = "답변하기"
        
        navigationItem.setRightBarButton(UIBarButtonItem(image:UIImage(systemName:"magnifyingglass")!.withTintColor(.black, renderingMode: .alwaysOriginal) , style: .plain, target: self, action: #selector(onSearchButtonPressed)), animated: true)
        
        
        sortMethodSegment = PlainSegmentedControl(items:["최신순","공감순"])
        sortMethodSegment.backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        sortMethodSegment.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor(red: 129/255.0, green: 129/255.0, blue: 129/255.0, alpha: 1),
                .font: UIFont.systemFont(ofSize: 20, weight:.regular)
            ],
            for: .normal
          )
        sortMethodSegment.setTitleTextAttributes(
            [
              NSAttributedString.Key.foregroundColor: BLUE_COLOR,
              .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ],
            for: .selected
          )
        sortMethodSegment.backgroundColor = .systemGray6
        sortMethodSegment.addTarget(self, action: #selector(onSegmentValueChanged(segment:)), for: .valueChanged)
        sortMethodSegment.selectedSegmentIndex = 0
        questionTable = UITableView()
        questionTable.delegate = self
        questionTable.dataSource = self
        questionTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        questionTable.register(QuestionTableViewCell.self,forCellReuseIdentifier: QuestionTableViewCell.ID)
        
        
        
        
        sortMethodSegment.translatesAutoresizingMaskIntoConstraints = false
        questionTable.translatesAutoresizingMaskIntoConstraints = false
        
       
        view.addSubview(sortMethodSegment)
        view.addSubview(questionTable)
        
        
    }
    func setConstraint(){
       
        NSLayoutConstraint.activate([
            sortMethodSegment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20.0),
            sortMethodSegment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20.0),
            sortMethodSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10.0),
            sortMethodSegment.heightAnchor.constraint(equalToConstant: 50.0)
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
            viewModel.getRecentQuestions()
        }
        else{
            viewModel.getRecentQuestions()
        }
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

extension AnswerViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questionListModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.ID) as! QuestionTableViewCell
        cell.configure(question:viewModel.questionListModelList[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(QuestionDetailViewController(), animated: true)
    }
    
    
}
