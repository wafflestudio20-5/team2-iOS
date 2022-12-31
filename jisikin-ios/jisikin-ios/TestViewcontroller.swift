//
//  TestViewcontroller.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2022/12/31.
//

import UIKit

class TestViewController: UIViewController {
    
    let repo = TestRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        repo.helloWorld()
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
