//
//  Lookbooks.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/12/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Lookbooks: Decodable {
    
    var lookbooks: [Lookbook]?
    
    private enum CodingKeys: String, CodingKey {
        case lookbooks = "response"
    }
    
    init(lookbooks: [Lookbook]) {
        self.lookbooks = lookbooks
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lookbooks = try? values.decode([Lookbook].self, forKey: .lookbooks)
    }
}
