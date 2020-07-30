//
//  Player.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Player: Decodable {
    
    var name: String?
    var socials: Socials?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case socials = "social"
    }
    
    init(name: String, socials: Socials) {
        self.name = name
        self.socials = socials
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self, forKey: .name)
        socials = try? values.decode(Socials.self, forKey: .socials)
    }
}
