//
//  HomeViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/10.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    var randomBanner = UIImageView()
    var newYearBanner = UIImageView()
    var helpAnswerBanner = UIImageView()
    var devBanner = UIImageView()
    
    var myQuestionView = UIView()
    var myQuestionTitleLabel = UILabel()
    var myQuestionCountLabel = UILabel()
    var myQuestionButton = UIButton()
    var loginLabel = UILabel()
    var loginButton = UIButton()
    
    var myQuestionTable = UITableView()
    var viewModel = MyRelatedQuestionListViewModel(usecase:MyRelatedQuestionUsecase())
    var bag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 7
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .center
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadQuestions()
        resetView()
        setMyQuestionView()
        setConstraint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setBackButton()
        setLayout()
        setView()
        setImageView()
        setMyQuestionView()
        setConstraint()

    }
    
    func reloadQuestions() {
        if(UserDefaults.standard.bool(forKey: "isLogin")){
            self.myQuestionTable.deselectSelectedRow(animated: false)
            viewModel.getMyQuestions()
        }
    }
    
    func resetView() {
        if(UserDefaults.standard.bool(forKey: "isLogin")){
            verticalStackView.removeFromSuperview()
            myQuestionView.addSubview(myQuestionCountLabel)
            myQuestionView.addSubview(myQuestionButton)
            myQuestionView.addSubview(myQuestionTable)
        }
        
        else{
            myQuestionView.addSubview(verticalStackView)
            myQuestionCountLabel.removeFromSuperview()
            myQuestionButton.removeFromSuperview()
            myQuestionTable.removeFromSuperview()
        }
    }
    
    func setBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(named: "MainColor")
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func setLayout() {
        view.backgroundColor = .white

        navigationController?.isNavigationBarHidden = false
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "지식2n"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        navigationItem.setRightBarButton(UIBarButtonItem(image:UIImage(systemName:"magnifyingglass")!.withTintColor(.black, renderingMode: .alwaysOriginal) , style: .plain, target: self, action: #selector(onSearchButtonPressed)), animated: true)
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        myQuestionView.translatesAutoresizingMaskIntoConstraints = false
        myQuestionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        myQuestionCountLabel.translatesAutoresizingMaskIntoConstraints = false
        myQuestionButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(horizontalStackView)
        
        view.addSubview(myQuestionView)
        myQuestionView.addSubview(myQuestionTitleLabel)
        myQuestionView.addSubview(myQuestionCountLabel)
        myQuestionView.addSubview(myQuestionButton)
        myQuestionView.addSubview(myQuestionTable)
        myQuestionView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(loginLabel)
        verticalStackView.addArrangedSubview(loginButton)
    }
    
    func setImageView() {
        randomBanner = UIImageView(image: UIImage(named: "RandomQuestion"))
        newYearBanner = UIImageView(image: UIImage(named: "NewYearGoal"))
        helpAnswerBanner = UIImageView(image: UIImage(named: "HelpAnswer"))
        devBanner = UIImageView(image: UIImage(named: "DevsOfJisik2n"))
        
        NSLayoutConstraint.activate([
            randomBanner.widthAnchor.constraint(equalToConstant: 168),
            randomBanner.heightAnchor.constraint(equalToConstant: 200),
            newYearBanner.widthAnchor.constraint(equalToConstant: 168),
            newYearBanner.heightAnchor.constraint(equalToConstant: 200),
            helpAnswerBanner.widthAnchor.constraint(equalToConstant: 168),
            helpAnswerBanner.heightAnchor.constraint(equalToConstant: 200),
            devBanner.widthAnchor.constraint(equalToConstant: 168),
            devBanner.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        horizontalStackView.addArrangedSubview(randomBanner)
        horizontalStackView.addArrangedSubview(newYearBanner)
        horizontalStackView.addArrangedSubview(helpAnswerBanner)
        horizontalStackView.addArrangedSubview(devBanner)
        
        randomBanner.layer.shadowOffset = CGSize(width: 5, height: 5)
        randomBanner.layer.shadowOpacity = 0.7
        randomBanner.layer.shadowRadius = 5
        randomBanner.layer.shadowColor = UIColor.gray.cgColor
        
        newYearBanner.layer.shadowOffset = CGSize(width: 5, height: 5)
        newYearBanner.layer.shadowOpacity = 0.7
        newYearBanner.layer.shadowRadius = 5
        newYearBanner.layer.shadowColor = UIColor.gray.cgColor

        helpAnswerBanner.layer.shadowOffset = CGSize(width: 5, height: 5)
        helpAnswerBanner.layer.shadowOpacity = 0.7
        helpAnswerBanner.layer.shadowRadius = 5
        helpAnswerBanner.layer.shadowColor = UIColor.gray.cgColor

        devBanner.layer.shadowOffset = CGSize(width: 5, height: 5)
        devBanner.layer.shadowOpacity = 0.7
        devBanner.layer.shadowRadius = 5
        devBanner.layer.shadowColor = UIColor.gray.cgColor
        
        let randomTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let newYearTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let helpAnswerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let devBannerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        randomBanner.isUserInteractionEnabled = true
        randomBanner.addGestureRecognizer(randomTapGestureRecognizer)
        
        newYearBanner.isUserInteractionEnabled = true
        newYearBanner.addGestureRecognizer(newYearTapGestureRecognizer)

        helpAnswerBanner.isUserInteractionEnabled = true
        helpAnswerBanner.addGestureRecognizer(helpAnswerTapGestureRecognizer)

        devBanner.isUserInteractionEnabled = true
        devBanner.addGestureRecognizer(devBannerTapGestureRecognizer)
    }
    
    func setMyQuestionView() {
        myQuestionView.backgroundColor = .white
        myQuestionView.layer.masksToBounds = false
        myQuestionView.clipsToBounds = true
        myQuestionView.layer.cornerRadius = 20
        myQuestionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        myQuestionView.layer.shadowColor = UIColor.gray.cgColor
        myQuestionView.layer.shadowOffset = CGSize(width: 0.0, height : -3.0)
        myQuestionView.layer.shadowOpacity = 0.5
        myQuestionView.layer.shadowRadius = 3
        
        myQuestionTitleLabel.text = "나의 질문"
        myQuestionTitleLabel.textColor = .black
        myQuestionTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
        if(UserDefaults.standard.bool(forKey: "isLogin")){
            
            myQuestionCountLabel.text = "0"
            myQuestionCountLabel.textColor = UIColor(named: "MainColor")
            myQuestionCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
            
            myQuestionButton.setTitle("전체보기 >", for: .normal)
            myQuestionButton.setTitleColor(.gray, for: .normal)
            myQuestionButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            myQuestionButton.addTarget(self, action: #selector(myQuestionButtonTapped), for: .touchUpInside)
            
            setMyQuestionTable()
        }
    
        else {
            loginLabel.text = "로그인 후 확인 가능합니다."
            loginLabel.font = UIFont.systemFont(ofSize: 20)
            loginLabel.textColor = .black
            
            loginButton.setTitle("로그인", for: .normal)
            loginButton.setTitleColor(.white, for: .normal)
            loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            loginButton.backgroundColor = UIColor(named: "MainColor")
            loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        }
    }
    
    func setMyQuestionTable() {
        myQuestionTable = UITableView()
        myQuestionTable.delegate = self
    
        myQuestionTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        myQuestionTable.register(QuestionTableViewCellForHomeVC.self,forCellReuseIdentifier: QuestionTableViewCellForHomeVC.ID)
        myQuestionTable.refreshControl = UIRefreshControl()
        myQuestionTable.refreshControl?.addTarget(self, action: #selector(onQuestionRefresh), for: .valueChanged)
        
        viewModel.questions.asObservable().bind(to:myQuestionTable.rx.items(cellIdentifier: QuestionTableViewCellForHomeVC.ID)){index,model,cell in
            (cell as! QuestionTableViewCellForHomeVC).configure(question:model)
            
            self.myQuestionCountLabel.text = String(self.myQuestionTable.numberOfRows(inSection: 0))
          
        }.disposed(by: bag)
        viewModel.getMyQuestions()
        
        myQuestionView.addSubview(myQuestionTable)
        myQuestionTable.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 230)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            horizontalStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        horizontalStackView.isLayoutMarginsRelativeArrangement = true
        horizontalStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        
        NSLayoutConstraint.activate([
            myQuestionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myQuestionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myQuestionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            myQuestionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            myQuestionTitleLabel.leadingAnchor.constraint(equalTo: myQuestionView.leadingAnchor, constant: 30),
            myQuestionTitleLabel.topAnchor.constraint(equalTo: myQuestionView.topAnchor, constant: 15)
        ])
        
        if(UserDefaults.standard.bool(forKey: "isLogin")){
            NSLayoutConstraint.activate([
                myQuestionCountLabel.leadingAnchor.constraint(equalTo: myQuestionTitleLabel.trailingAnchor, constant: 5),
                myQuestionCountLabel.centerYAnchor.constraint(equalTo: myQuestionTitleLabel.centerYAnchor)
            ])
            
            NSLayoutConstraint.activate([
                myQuestionButton.trailingAnchor.constraint(equalTo: myQuestionView.trailingAnchor, constant: -30),
                myQuestionButton.centerYAnchor.constraint(equalTo: myQuestionTitleLabel.centerYAnchor)
            ])
            
            
            NSLayoutConstraint.activate([
                myQuestionTable.topAnchor.constraint(equalTo: myQuestionTitleLabel.bottomAnchor, constant: 10),
                myQuestionTable.bottomAnchor.constraint(equalTo: myQuestionView.bottomAnchor),
                myQuestionTable.leftAnchor.constraint(equalTo: myQuestionTitleLabel.leftAnchor, constant: -20),
                myQuestionTable.rightAnchor.constraint(equalTo: myQuestionButton.rightAnchor, constant: 20)
            ])
        }
        
        else {
            NSLayoutConstraint.activate([
                verticalStackView.centerXAnchor.constraint(equalTo: myQuestionView.centerXAnchor),
                verticalStackView.centerYAnchor.constraint(equalTo: myQuestionView.centerYAnchor)
            ])
            NSLayoutConstraint.activate([
                loginButton.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 20),
            ])
        }
    }
    
    @objc func onSearchButtonPressed(){
        navigationController?.pushViewController(SearchViewController(), animated: false)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch tappedImage{
        case randomBanner:
            let viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())
            viewModel.getQuestionsByDate()
            viewModel.getRandomQuestionID(completionHandler: { randomID in
                self.navigationController?.pushViewController(QuestionDetailViewController(viewModel: QuestionDetailViewModel(usecase: viewModel.usecase, questionID: randomID)), animated: true)
            })
        case newYearBanner:
            let viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())
            viewModel.getQuestionsByDate()
            viewModel.getAdminQuestionID(completionHandler: { questionID in
                self.navigationController?.pushViewController(QuestionDetailViewController(viewModel: QuestionDetailViewModel(usecase: viewModel.usecase, questionID: questionID)), animated: true)
            })
        case helpAnswerBanner:
            self.tabBarController?.selectedIndex = 1
        case devBanner:
            let vc = DevViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    @objc func myQuestionButtonTapped() {
        let vc = MyQAViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonTapped() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onQuestionRefresh(){
        viewModel.getMyQuestions()
       
        self.myQuestionTable.refreshControl?.endRefreshing()
    }
}

extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(QuestionDetailViewController(viewModel: QuestionDetailViewModel(usecase: QuestionAnswerUsecase(), questionID: viewModel.questions.value[indexPath.row].id)), animated: true)
    }
}
