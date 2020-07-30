//
//  CreatorsApi.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/11/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation
import Alamofire

class CreatorsApi {
    var baseUrl = "\(Api.basePath)/creator"
    
    func getCreators(withCompletion completion: @escaping (_ creators: Creators) -> Void) {
        AF.request("\(baseUrl)/creators", method: .get, headers: Api.headers).responseDecodable(of: Creators.self) { (response) in
            guard let creators = response.value else { return }
            completion(creators)
        }
    }
}
