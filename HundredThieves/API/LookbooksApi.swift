//
//  LookbooksApi.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/12/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation
import Alamofire

class LookbooksApi {
    var baseUrl = "\(Api.basePath)/lookbook"
    
    func getLookbooks(withCompletion completion: @escaping (_ lookbooks: Lookbooks) -> Void) {
        AF.request("\(baseUrl)/lookbooks", method: .get, headers: Api.headers).responseDecodable(of: Lookbooks.self) { (response) in
            guard let lookbooks = response.value else { return }
            completion(lookbooks)
        }
    }
}
