//
//  HomeViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/10.
//

import UIKit

class HomeViewController: UIViewController {
    var randomBanner = UIImageView()
    var newYearBanner = UIImageView()
    var helpAnswerBanner = UIImageView()
    var devBanner = UIImageView()
    
    private let scrollView: UIScrollView = {
        let view: UIScrollView = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 7
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setLayout()
        setView()
        setImageView()
        setConstraint()
    }
    
    func setLayout() {
        navigationController?.isNavigationBarHidden = false
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "지식2n"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        navigationItem.setRightBarButton(UIBarButtonItem(image:UIImage(systemName:"magnifyingglass")!.withTintColor(.black, renderingMode: .alwaysOriginal) , style: .plain, target: self, action: #selector(onSearchButtonPressed)), animated: true)
    }
    
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
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
        
        stackView.addArrangedSubview(randomBanner)
        stackView.addArrangedSubview(newYearBanner)
        stackView.addArrangedSubview(helpAnswerBanner)
        stackView.addArrangedSubview(devBanner)
        
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
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 230)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
    }
    
    @objc func onSearchButtonPressed(){
        navigationController?.pushViewController(SearchViewController(), animated: false)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        switch tappedImage{
        case randomBanner:
            let randomInt = Int.random(in: 1..<10)
            let viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())
            viewModel.getQuestions()
            navigationController?.pushViewController(QuestionDetailViewController(viewModel: QuestionDetailViewModel(usecase: viewModel.usecase, questionID: randomInt)), animated: true)
        case newYearBanner:
            print("hello new")
        case helpAnswerBanner:
            print("hello help")
        case devBanner:
            print("hello dev")
        default:
            break
        }
    }
}
