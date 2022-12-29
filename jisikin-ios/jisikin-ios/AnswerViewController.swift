//
//  AnswerViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

let BLUE_COLOR = UIColor(red: 111/255.0, green:200/255.0, blue: 240/255.0, alpha: 1.0)
let dummy = [
    Question(title: "학원 미환불 교육청민원", content:"학원에서 교습비를 미환불해줘서 교육청에서 주의,권고로 끝냈습니다. 처음이라고요 결국 학원측에서 환불해준다해놓고 4일째인데 안들어옵니더 수강일 넘어서 3분의1떼고 환불해줄심보인지 전산상문제인지모르겠지만 내일 본사전화해보고 안되겠으면, 교육청에 재신고할예정인데 2차니까 교습정지처분 인가요?", time: "1일 전", likeNumber: 1, answerNumber: 2),
    Question(title: "title2", content:"content2", time: "1일 전", likeNumber: 1, answerNumber: 2),
    Question(title: "title3", content:"content3", time: "1일 전", likeNumber: 1, answerNumber: 2),
    Question(title: "title4", content:"content4", time: "1일 전", likeNumber: 1, answerNumber: 2),
    Question(title: "title5", content:"content5", time: "1일 전", likeNumber: 1, answerNumber: 2),

]
class QuestionTableViewCell:UITableViewCell{
    
    static let ID = "QuestionTableViewCell"
    
    var questionTitleView:UILabel!
    var questionContentView:UILabel!
    var postedTimeView:UILabel!
    var answerNumberView:UILabel!
    var likeNumberView:UILabel!
    var lineBetweenTimeAndAnswerNumber:UIView!
    var lineBetweenAnswerNumberAndLikeNumber:UIView!
    var lineAtBottom:UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        questionTitleView = UILabel()
        questionTitleView.numberOfLines = 1
        questionTitleView.textColor = .black
        questionTitleView.font = questionTitleView.font.withSize(20)
        questionTitleView.lineBreakMode = .byTruncatingTail
        
        
        questionContentView = UILabel()
        questionContentView.numberOfLines = 2
        questionContentView.font = questionContentView.font.withSize(25)
        questionContentView.textColor = .gray
        
        postedTimeView = UILabel()
        postedTimeView.textColor = .gray
        
        lineBetweenTimeAndAnswerNumber = UIView()
        lineBetweenTimeAndAnswerNumber.backgroundColor = .gray
        
        answerNumberView = UILabel()
        answerNumberView.textAlignment = .center
        answerNumberView.font = answerNumberView.font.withSize(20)
        answerNumberView.backgroundColor = .systemGray6
        
        likeNumberView = UILabel()
        likeNumberView.textAlignment = .center
        likeNumberView.font = likeNumberView.font.withSize(20)
        likeNumberView.backgroundColor = .systemGray6
        
        lineBetweenAnswerNumberAndLikeNumber = UIView()
        lineBetweenAnswerNumberAndLikeNumber.backgroundColor = .gray
        
        lineAtBottom = UIView()
        lineAtBottom.backgroundColor = .gray
        
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
        postedTimeView.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenTimeAndAnswerNumber.translatesAutoresizingMaskIntoConstraints = false
        answerNumberView.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenAnswerNumberAndLikeNumber.translatesAutoresizingMaskIntoConstraints = false
        likeNumberView.translatesAutoresizingMaskIntoConstraints = false
        lineAtBottom.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(questionTitleView)
        contentView.addSubview(questionContentView)
        contentView.addSubview(postedTimeView)
        contentView.addSubview(lineBetweenTimeAndAnswerNumber)
        contentView.addSubview(answerNumberView)
        contentView.addSubview(lineBetweenAnswerNumberAndLikeNumber)
        contentView.addSubview(likeNumberView)
        contentView.addSubview(lineAtBottom)
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            questionTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20.0)
                        
        ])
        NSLayoutConstraint.activate([
            questionContentView.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 5.0),
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor)
            
        ])
        NSLayoutConstraint.activate([
            postedTimeView.topAnchor.constraint(equalTo: questionContentView.bottomAnchor,constant: 5.0),
            postedTimeView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            lineBetweenTimeAndAnswerNumber.topAnchor.constraint(equalTo: postedTimeView.bottomAnchor,constant: 5.0),
            lineBetweenTimeAndAnswerNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineBetweenTimeAndAnswerNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineBetweenTimeAndAnswerNumber.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        NSLayoutConstraint.activate([
            answerNumberView.topAnchor.constraint(equalTo: lineBetweenTimeAndAnswerNumber.bottomAnchor),
            answerNumberView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
        
            answerNumberView.heightAnchor.constraint(equalToConstant: 50.0),
          
        ])
        NSLayoutConstraint.activate([
            lineBetweenAnswerNumberAndLikeNumber.widthAnchor.constraint(equalToConstant: 2.0),
            lineBetweenAnswerNumberAndLikeNumber.topAnchor.constraint(equalTo: answerNumberView.topAnchor),
            lineBetweenAnswerNumberAndLikeNumber.leadingAnchor.constraint(equalTo: answerNumberView.trailingAnchor),
            lineBetweenAnswerNumberAndLikeNumber.bottomAnchor.constraint(equalTo: answerNumberView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            likeNumberView.topAnchor.constraint(equalTo: answerNumberView.topAnchor),
            likeNumberView.leadingAnchor.constraint(equalTo: lineBetweenAnswerNumberAndLikeNumber.trailingAnchor),
            likeNumberView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            likeNumberView.bottomAnchor.constraint(equalTo: answerNumberView.bottomAnchor),
            likeNumberView.widthAnchor.constraint(equalTo: answerNumberView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            lineAtBottom.topAnchor.constraint(equalTo: answerNumberView.bottomAnchor),
            lineAtBottom.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            lineAtBottom.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            lineAtBottom.heightAnchor.constraint(equalToConstant: 5.0),
            lineAtBottom.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func configure(question:Question){
        questionTitleView.text = question.title
        questionContentView.text = question.content
        postedTimeView.text = question.time
        answerNumberView.text = "답변 \(question.answerNumber)"
        likeNumberView.text = "공감 \(question.likeNumber)"
    }
    
}
class AnswerViewController: UIViewController {
    
   
    
    var titleView:UILabel!
    var searchButton:UIButton!
    var sortMethodSegment:PlainSegmentedControl!
    var questionTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setLayout()
        setConstraint()
        // Do any additional setup after loading the view.
        
    }
    func setLayout(){
        titleView = UILabel()
        titleView.text = "답변하기"
        titleView.font = titleView.font.withSize(40.0)
        
        searchButton = UIButton()
        searchButton.setImage(UIImage(systemName:"magnifyingglass",withConfiguration: UIImage.SymbolConfiguration(scale: .large)),for:.normal)
        
        sortMethodSegment = PlainSegmentedControl(items:["최신순","공감순"])
        sortMethodSegment.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
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
        
        questionTable = UITableView()
        questionTable.delegate = self
        questionTable.dataSource = self
        questionTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        questionTable.register(QuestionTableViewCell.self,forCellReuseIdentifier: QuestionTableViewCell.ID)
        
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        sortMethodSegment.translatesAutoresizingMaskIntoConstraints = false
        questionTable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleView)
        view.addSubview(searchButton)
        view.addSubview(sortMethodSegment)
        view.addSubview(questionTable)
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -80),
            titleView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            searchButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20.0)
            
        ])
        NSLayoutConstraint.activate([
            sortMethodSegment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20.0),
            sortMethodSegment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant:-20.0),
            sortMethodSegment.topAnchor.constraint(equalTo: titleView.bottomAnchor,constant: 5.0),
            sortMethodSegment.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        NSLayoutConstraint.activate([
            questionTable.topAnchor.constraint(equalTo: sortMethodSegment.bottomAnchor,constant:10.0),
            questionTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            questionTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            questionTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
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
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.ID) as! QuestionTableViewCell
        cell.configure(question:dummy[indexPath.row])
        return cell
        
    }
    
    
}
