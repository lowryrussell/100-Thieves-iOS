//
//  LeaguesApi.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation
import Alamofire

class LeaguesApi {
    var baseUrl = "\(Api.basePath)/league"
    
    func getLeagues(withCompletion completion: @escaping (_ leagues: Leagues) -> Void) {
        AF.request("\(baseUrl)/leagues", method: .get, headers: Api.headers).responseDecodable(of: Leagues.self) { (response) in
            guard let leagues = response.value else { return }
            completion(leagues)
        }
    }
}
