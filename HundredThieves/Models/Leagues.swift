//
//  Leagues.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Leagues: Decodable {
    
    var leagues: [League]?
    
    private enum CodingKeys: String, CodingKey {
        case leagues = "response"
    }
    
    init(leagues: [League]) {
        self.leagues = leagues
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        leagues = try? values.decode([League].self, forKey: .leagues)
    }
}
