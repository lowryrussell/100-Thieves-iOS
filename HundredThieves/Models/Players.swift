//
//  Players.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Players: Decodable {
    
    var players: [Player]?
    
    private enum CodingKeys: String, CodingKey {
        case players = "players"
    }
    
    init(players: [Player]) {
        self.players = players
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        players = try? values.decode([Player].self, forKey: .players)
    }
}
