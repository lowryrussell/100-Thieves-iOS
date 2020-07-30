//
//  League.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class League: Decodable {
    
    var name: String?
    var players: [Player]?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case players = "players"
    }
    
    init(name: String, players: [Player]) {
        self.name = name
        self.players = players
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self, forKey: .name)
        players = try? values.decode([Player].self, forKey: .players)
    }
}
