import UIKit
let dummy = [
    Question(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus sit amet convallis purus. Praesent auctor, justo eu feugiat consequat, lorem lacus vestibulum velit, eget luctus mi tellus a lacus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Duis at nibh enim. Ut aliquet porta elit sit amet fringilla. Nullam tincidunt orci ut neque porta, ut semper diam posuere. Sed commodo nisl quis dolor hendrerit eleifend. Nullam ornare odio eget elit tincidunt, a faucibus dui porta. Integer molestie in nisl sit amet facilisis. Ut nunc nisi, malesuada ac iaculis nec, accumsan eu nisi. Cras ut ultrices eros, ut dictum nisl. Nulla lobortis consequat ipsum at interdum.", content:"Maecenas at viverra magna. Suspendisse iaculis, mi ut sagittis convallis, odio est mattis eros, sed ultrices dolor arcu id nibh. Morbi in est placerat, dapibus justo eget, finibus erat. Pellentesque feugiat suscipit finibus. Proin venenatis nisi quam, et molestie velit convallis finibus. Praesent blandit, ligula sit amet ultrices dignissim, odio nisi rhoncus massa, vel ullamcorper mi nisl at diam. Pellentesque tellus eros, lacinia non pretium ac, placerat a felis. Donec vitae pretium metus. Vestibulum lectus est, lobortis sed ex sit amet, sollicitudin elementum libero. Praesent at vulputate ex. Donec ultrices magna a dui finibus porttitor non eget enim. Quisque auctor malesuada ex, sed luctus leo blandit et.", time: "1일 전", likeNumber: 1, answerNumber: 2),
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
    var lineAtTop:UIView!
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
        questionContentView.textColor = .init(red: 194/255, green: 194/255, blue: 194/255, alpha: 1)
        
        postedTimeView = UILabel()
        postedTimeView.textColor = .gray
        postedTimeView.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
        lineBetweenTimeAndAnswerNumber = UIView()
        lineBetweenTimeAndAnswerNumber.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
    
        answerNumberView = UILabel()
        answerNumberView.textAlignment = .center
        answerNumberView.font = answerNumberView.font.withSize(20)
        answerNumberView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
        likeNumberView = UILabel()
        likeNumberView.textAlignment = .center
        likeNumberView.font = likeNumberView.font.withSize(20)
        likeNumberView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
        lineBetweenAnswerNumberAndLikeNumber = UIView()
        lineBetweenAnswerNumberAndLikeNumber.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        
        lineAtBottom = UIView()
        lineAtBottom.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)

        lineAtTop = UIView()
        lineAtTop.backgroundColor = UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
        
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
        postedTimeView.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenTimeAndAnswerNumber.translatesAutoresizingMaskIntoConstraints = false
        answerNumberView.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenAnswerNumberAndLikeNumber.translatesAutoresizingMaskIntoConstraints = false
        likeNumberView.translatesAutoresizingMaskIntoConstraints = false
        lineAtBottom.translatesAutoresizingMaskIntoConstraints = false
        lineAtTop.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(questionTitleView)
        contentView.addSubview(questionContentView)
        contentView.addSubview(postedTimeView)
        contentView.addSubview(lineBetweenTimeAndAnswerNumber)
        contentView.addSubview(answerNumberView)
        contentView.addSubview(lineBetweenAnswerNumberAndLikeNumber)
        contentView.addSubview(likeNumberView)
        contentView.addSubview(lineAtBottom)
        contentView.addSubview(lineAtTop)
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            lineAtTop.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            lineAtTop.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            lineAtTop.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            lineAtTop.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: lineAtTop.bottomAnchor,constant:10.0),
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
    func configure(question:QuestionListVM){
        questionTitleView.text = question.title
        questionContentView.text = question.content
        postedTimeView.text = question.createdAt
        answerNumberView.text = question.answerNumber != nil ? "답변 \(question.answerNumber!)" : "답변"
        likeNumberView.text = "공감"
    }
    
}

