//
//  Socials.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/19/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Socials: Decodable {
    
    var social: String?
    var twitter: String?
    
    private enum CodingKeys: String, CodingKey {
        case social = "social"
        case twitter = "twitter"
    }
    
    init(social: String, twitter: String) {
        self.social = social
        self.twitter = twitter
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        twitter = try? values.decode(String.self, forKey: .twitter)
    }
}
