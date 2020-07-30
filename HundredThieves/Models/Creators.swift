//
//  Creators.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/11/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Creators: Decodable {
    
    var creators: [Creator]?
    
    private enum CodingKeys: String, CodingKey {
        case creators = "response"
    }
    
    init(creators: [Creator]) {
        self.creators = creators
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        creators = try? values.decode([Creator].self, forKey: .creators)
    }
}
