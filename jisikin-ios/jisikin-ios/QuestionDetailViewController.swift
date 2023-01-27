import Foundation
import Kingfisher
import RxSwift
import RxCocoa
import UIKit

class QuestionDetailViewController:UIViewController{
    var bag = DisposeBag()
    var answerTableView:UITableView!
    var questionView = QuestionView()
    var headerView : UITableViewHeaderFooterView!
    var viewModel:QuestionDetailViewModel
    var username:String? = nil
    init(viewModel:QuestionDetailViewModel){
        self.viewModel = viewModel
    //    viewModel.refresh()
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
      
      viewModel.refresh()
        answerTableView.reloadData()
        
   }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.performWithoutAnimation{[weak self] in
            self?.answerTableView.beginUpdates()
            self?.answerTableView.endUpdates()
            
        }
    }
    
    /*  override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     
     if let headerView = answerTableView.tableHeaderView {
     
     let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
     var headerFrame = headerView.frame
     
     //Comparison necessary to avoid infinite loop
     if height != headerFrame.size.height {
     headerFrame.size.height = height
     headerView.frame = headerFrame
     answerTableView.tableHeaderView = headerView
     }
     headerView.translatesAutoresizingMaskIntoConstraints = false
     
     }
     }*/
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //        viewModel.refresh()
    //    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
     //   viewModel.refresh()
        setLayout()
        setConstraint()
        
        // Do any additional setup after loading the view.
        viewModel.question.subscribe(onNext: {[weak self]
            question in
            if self==nil{return}
            if let question{
                self!.questionView.configure(question:question,hasAnswers:self!.viewModel.answers.value.count != 0)
                
            }
            
        }).disposed(by: bag)
        viewModel.answers.subscribe(onNext: {[weak self]
            answers in
            
            if self==nil{return}
            if self!.viewModel.question.value == nil{return}
            self!.questionView.configure(question:self!.viewModel.question.value!,hasAnswers:answers.count != 0)
            
            
            
        }).disposed(by: bag)
        
        viewModel.answers.bind(to:answerTableView.rx.items(cellIdentifier: AnswerTableCell.ID)){ [weak self] index,model,cell in
            if self == nil{return}
          
            (cell as! AnswerTableCell).onImageLoaded = {
                UIView.performWithoutAnimation{
                    self?.answerTableView.beginUpdates()
                    self?.answerTableView.endUpdates()
                    print("ID print:")
                }
            }
            
            (cell as! AnswerTableCell).configure(answer:model,question:self!.viewModel.question.value)
            
            self!.viewModel.question.subscribe(onNext: {
                question in
                if let question{
                    
                    (cell as! AnswerTableCell).configure(answer:model,question:question)
                }
            }).disposed(by: self!.bag)
            (cell as! AnswerTableCell).onSelectButtonPressed = { [weak self] in
                print("pressed")
                if self == nil{return}
                self!.viewModel.selectAnswer(index: index).subscribe(onSuccess: {[weak self] _ in
                    self!.viewModel.refresh()
                },onError:{
                    _ in
                    print("채택 실패")
                })
                
            }
          
            (cell as! AnswerTableCell).setOnAgreeButtonClicked(){ [weak self] in
                if UserDefaults.standard.bool(forKey: "isLogin"){
                    self!.viewModel.agreeAnswer(index: index, isAgree: true).subscribe(onSuccess: {[weak self] _ in
                        (cell as! AnswerTableCell).pressAgree()
                    } ).disposed(by: self!.bag)
                }
                else{
                    self!.showLoginAlert{[weak self] in
                        self!.tabBarController?.navigationController?.popViewController(animated: true)
                    }
                }
            }
            (cell as! AnswerTableCell).setOnDisAgreeButtonClicked(){ [weak self] in
                if UserDefaults.standard.bool(forKey: "isLogin"){
                    self!.viewModel.agreeAnswer(index: index, isAgree: false).subscribe(onSuccess: {[weak self] _ in
                        (cell as! AnswerTableCell).pressDisagree()
                    } ).disposed(by: self!.bag)
                }
                else{
                    self!.showLoginAlert{[weak self] in
                        self!.tabBarController?.navigationController?.popViewController(animated: true)
                    }
                }
            }
            (cell as! AnswerTableCell).onDeleteButtonPressed = {
                [weak self] in
                self!.viewModel.deleteAnswer(index: index).subscribe(onSuccess: { _ in
                    self!.viewModel.refresh()
                }).disposed(by: self!.bag)
            }
            
        }.disposed(by: bag)
  /*     UserDefaults.standard.rx.observe(String.self,"username").subscribe(onNext: {
          [weak self]  _ in
            print("username change")
           print("ID print:\(self!.viewModel.questionID)")
            self!.viewModel.refresh()
        }).disposed(by: bag)*/
        
    }
    func setLayout(){
        
        navigationController?.isNavigationBarHidden = false
        
        
        answerTableView = UITableView(frame: .zero, style: .grouped)
        answerTableView.delegate = self
        
        answerTableView.register(AnswerTableCell.self, forCellReuseIdentifier: AnswerTableCell.ID)
        answerTableView.backgroundColor = .white
        answerTableView.sectionHeaderHeight = UITableView.automaticDimension
        answerTableView.rowHeight = UITableView.automaticDimension
        
        answerTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(answerTableView)
        
    }
    func setConstraint(){
        
        NSLayoutConstraint.activate([
            answerTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            answerTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            answerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            answerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension QuestionDetailViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        questionView.onImageLoaded = {
            tableView.reloadData()
        }
        
        questionView.setOnAnswerButtonClicked(){[weak self] in
            if UserDefaults.standard.bool(forKey: "isLogin"){
                let username = UserDefaults.standard.string(forKey: "username")
                if let idx =  self!.viewModel.answers.value.firstIndex(where: {$0.username == username}){
                    self!.showToast(message: "동일한 질문에는 하나의 답변 작성이 가능합니다.")
                    return
                }
                if username == self!.viewModel.question.value?.username{
                    self!.showToast(message: "자신의 질문에는 답할 수 없습니다.")
                    return
                }
                var vc = WritingAnswerViewController()
                vc.questionID = (self?.viewModel.questionID)!
            
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self?.showLoginAlert{
                    self?.tabBarController?.navigationController?.popViewController(animated: false){
                        var vc = WritingAnswerViewController()
                        vc.questionID = (self?.viewModel.questionID)!
                  
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        questionView.setOnLikeButtonClicked() {[weak self] in
            if self == nil{return}
            if UserDefaults.standard.bool(forKey: "isLogin"){
                self!.viewModel.likeQuestion().subscribe(onSuccess:{
                    _ in
                    self!.questionView.likeButtonPressed()
                }).disposed(by: self!.bag)
            }
            else{
                self!.showLoginAlert{
                    self!.tabBarController?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        questionView.onDeleteButtonClicked = {[weak self] in
            if self == nil{return}
            self!.viewModel.deleteQuestion().subscribe(onSuccess:{[weak self]
                _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: self!.bag)
        }
        questionView.translatesAutoresizingMaskIntoConstraints = false
        let headerView = UITableViewHeaderFooterView()
        headerView.contentView.addSubview(questionView)
        
        NSLayoutConstraint.activate([
            questionView.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor),
            questionView.topAnchor.constraint(equalTo: headerView.contentView.topAnchor),
            questionView.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor),
            questionView.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor)
        ])
        return headerView
    }
    func showLoginAlert(onLogin:@escaping(()->())){
        let loginAction = UIAlertAction(title: "로그인", style: .default,handler: {[weak self]
            setAction in
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named:"BackgroundColor")
            appearance.shadowColor = .clear
            self?.tabBarController?.navigationController?.navigationBar.standardAppearance = appearance
            self?.tabBarController?.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            let vc = LoginViewController()
            
            vc.onLogin = onLogin
            
            
            
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = UIColor(named: "MainColor")
            self?.tabBarController?.navigationItem.backBarButtonItem = backBarButtonItem
            self?.tabBarController?.navigationController?.pushViewController(vc, animated: true)
            self?.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
            
        })
        let cancelAction = UIAlertAction(title:"취소",style:.default)
        let alert = UIAlertController(title:nil,message: "로그인이 필요합니다",preferredStyle: .alert)
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: false)
    }
    
    
}





extension UIColor {//for single color image
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
extension UINavigationController {
    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void)
    {
        popViewController(animated: animated)
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }
        
        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}

extension UIStackView {
    
    func safelyRemoveArrangedSubviews() {
        
        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }
        
        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
}
extension UIViewController{
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 20.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 200, y: self.view.frame.size.height-200, width: 400, height: 50))
        toastLabel.backgroundColor = UIColor.white
        toastLabel.textColor = UIColor(red: 1, green: 111/255, blue: 15/255, alpha: 1)
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.borderWidth = 1
        toastLabel.layer.borderColor = UIColor(red: 1, green: 111/255, blue: 15/255, alpha: 1).cgColor
        toastLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        toastLabel.layer.shadowOpacity = 0.3
        toastLabel.layer.shadowRadius = 2
        toastLabel.layer.shadowColor = UIColor(red: 1, green: 111/255, blue: 15/255, alpha: 1).cgColor
        
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
