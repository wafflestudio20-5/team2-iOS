//
//  TabBarViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let answerVC = AnswerViewController()
        let questionVC = QuestionViewController()
        let myVC = MyViewController()
        
        let answerNav = UINavigationController(rootViewController: answerVC)
        let questionNav = UINavigationController(rootViewController: questionVC)
        let myNav = UINavigationController(rootViewController: myVC)
        
        setViewControllers([answerNav, questionNav, myNav], animated: false)
        
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
        self.delegate = self
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
extension TabBarViewController:UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let nav = viewController as! UINavigationController
        if let  vc = ((nav.topViewController) as? QuestionViewController){
            
            if UserDefaults.standard.bool(forKey: "isLogin"){
                return true
            }
            else{
                showLoginAlert(nav: selectedViewController as! UINavigationController)
                
                return false
            }
        }
        return true
    }
   
    func showLoginAlert(nav:UINavigationController){
        let loginAction = UIAlertAction(title:"로그인",style: .default,handler: {
            setAction in
            nav.pushViewController(LoginViewController(), animated: true)
        })
        let cancelAction = UIAlertAction(title:"취소",style:.default)
        let alert = UIAlertController(title:nil,message: "로그인이 필요합니다",preferredStyle: .alert)
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: false)
    }
}
