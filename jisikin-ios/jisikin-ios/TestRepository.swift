//
//  Repository.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2022/12/31.
//

import Alamofire

final class TestRepository {
    let url = URL(string: "http://15.164.159.7/users")
    
    func helloWorld() {
        AF.request(url!,
                   method: .get)
        .response{
            response in
            
            switch response.result {
            case .success(let data):
                let utf8Text = String(data: data!, encoding: .utf8)
                print(utf8Text)

            case .failure(let error):
                print(error)
            }
        }
    }
}
