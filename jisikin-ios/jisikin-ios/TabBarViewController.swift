//
//  TabBarViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private var previousTabIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if selectedIndex == 2{
            selectedIndex = previousTabIndex
            print(previousTabIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let answerVC = AnswerViewController()
        let questionVC = QuestionViewController()
        let myVC = MyViewController()
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let answerNav = UINavigationController(rootViewController: answerVC)
        let questionNav = UINavigationController(rootViewController: questionVC)
        let myNav = UINavigationController(rootViewController: myVC)
        
        setViewControllers([homeNav, answerNav, UIViewController(), myNav], animated: false)
        
        tabBar.items![0].title = "지식2n 홈"
        tabBar.items![0].selectedImage = UIImage (systemName: "house")
        tabBar.items![0].image = UIImage (systemName: "house.fill")
        
        tabBar.items![1].title = "답변하기"
        tabBar.items![1].selectedImage = UIImage (systemName: "a.square.fill")
        tabBar.items![1].image = UIImage (systemName: "a.square")
        
        tabBar.items![2].title = "질문하기"
        tabBar.items![2].selectedImage = UIImage (systemName: "q.square.fill")
        tabBar.items![2].image = UIImage (systemName: "q.square")
        
        tabBar.items![3].title = "MY"
        tabBar.items![3].selectedImage = UIImage (systemName: "person.circle.fill")
        tabBar.items![3].image = UIImage (systemName: "person.circle")
        
        tabBar.backgroundColor = UIColor(red: 240, green: 240, blue: 240, alpha: 1.0)
        tabBar.isTranslucent = false
        
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let items = tabBar.items else { return }
        for (index, tabBarItem) in items.enumerated() where tabBarItem == item {
            //index는 1은 질문하기 탭
            if index == 2 {
            // 이전 인덱스로 화면 전환!
                // self.tabBarController?.selectedIndex = previousTabIndex
                if(UserDefaults.standard.bool(forKey: "isLogin")){
                    let baseNavigationController: UINavigationController = self.view.window?.rootViewController as! UINavigationController
                    baseNavigationController.pushViewController(QuestionViewController(), animated: false)
                }
             
                
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
extension TabBarViewController{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let nav = viewController as? UINavigationController
        if nav == nil{
            
            if UserDefaults.standard.bool(forKey: "isLogin"){
                return true
            }
            else{
                showLoginAlert(nav: navigationController!)
                
                return false
            }
        }
        return true
    }
    func showLoginAlert(nav:UINavigationController){
         let loginAction = UIAlertAction(title:"로그인",style: .default,handler: {[weak self]
             setAction in
             let appearance = UINavigationBarAppearance()
             appearance.configureWithOpaqueBackground()
             appearance.backgroundColor = UIColor(named:"BackgroundColor")
             appearance.shadowColor = .clear
             nav.navigationBar.standardAppearance = appearance
             nav.navigationBar.scrollEdgeAppearance = appearance
           
             let vc = LoginViewController()
            
             vc.onLogin = {
                 nav.popViewController(animated: false)
                 nav.pushViewController(QuestionViewController(), animated: true)
             }
             let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
             backBarButtonItem.tintColor = UIColor(named: "MainColor")
             self!.navigationItem.backBarButtonItem = backBarButtonItem
             nav.pushViewController(vc, animated: true)
             nav.setNavigationBarHidden(false, animated: false)
             
         })
         let cancelAction = UIAlertAction(title:"취소",style:.default)
         let alert = UIAlertController(title:nil,message: "로그인이 필요합니다",preferredStyle: .alert)
      alert.addAction(loginAction)
          alert.addAction(cancelAction)
          self.present(alert,animated: false)
      }
}
