//
//  TabBarViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answerVC = AnswerViewController()
        let questionVC = QuestionViewController()
        let myVC = MyViewController()
        
        answerVC.title = "답변하기"
        questionVC.title = "질문하기"
        myVC.title = "MY"
        
        let answerNav = UINavigationController(rootViewController: answerVC)
        let questionNav = UINavigationController(rootViewController: questionVC)
        let myNav = UINavigationController(rootViewController: myVC)
        
        setViewControllers([answerNav, questionNav, myNav], animated: false)
        
        tabBar.items![0].selectedImage = UIImage (systemName: "a.square.fill")
        tabBar.items![0].image = UIImage (systemName: "a.square")
        
        tabBar.items![1].selectedImage = UIImage (systemName: "q.square.fill")
        tabBar.items![1].image = UIImage (systemName: "q.square")
        
        tabBar.items![2].selectedImage = UIImage (systemName: "person.circle.fill")
        tabBar.items![2].image = UIImage (systemName: "person.circle")
        
        tabBar.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1.0)
        tabBar.isTranslucent = false
        // Do any additional setup after loading the view.
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
