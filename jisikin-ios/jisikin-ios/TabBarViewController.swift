//
//  TabBarViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

class TabBarViewController: UITabBarController {
    private var previousTabIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if selectedIndex == 1{
            selectedIndex = previousTabIndex
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answerVC = AnswerViewController()
        let questionVC = QuestionViewController()
        let myVC = MyViewController()
        
        let answerNav = UINavigationController(rootViewController: answerVC)
        let questionNav = UINavigationController(rootViewController: questionVC)
        let myNav = UINavigationController(rootViewController: myVC)
        
        setViewControllers([answerNav, UIViewController(), myNav], animated: false)
        
        tabBar.items![0].title = "답변하기"
        tabBar.items![0].selectedImage = UIImage (systemName: "a.square.fill")
        tabBar.items![0].image = UIImage (systemName: "a.square")
        
        tabBar.items![1].title = "질문하기"
        tabBar.items![1].selectedImage = UIImage (systemName: "q.square.fill")
        tabBar.items![1].image = UIImage (systemName: "q.square")
        
        tabBar.items![2].title = "MY"
        tabBar.items![2].selectedImage = UIImage (systemName: "person.circle.fill")
        tabBar.items![2].image = UIImage (systemName: "person.circle")
        
        tabBar.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1.0)
        tabBar.isTranslucent = false
        if selectedIndex == 1{
            selectedIndex = previousTabIndex
        }
        
        // Do any additional setup after loading the view.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items else { return }
        for (index, tabBarItem) in items.enumerated() where tabBarItem == item {
            //index는 1은 질문하기 탭
            if index == 1 {
            // 이전 인덱스로 화면 전환!
                // self.tabBarController?.selectedIndex = previousTabIndex
                let baseNavigationController: UINavigationController = self.view.window?.rootViewController as! UINavigationController
                baseNavigationController.pushViewController(QuestionViewController(), animated: false)
            } else {
            // 그 외의 화면들은 인덱스 업데이트!
                previousTabIndex = index
            }
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
