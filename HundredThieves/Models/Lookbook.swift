//
//  Lookbook.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/7/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Lookbook: Decodable {
    
    var name: String?
    var description: String?
    var image: String?
    
    init(name: String, description: String, image: String) {
        self.name = name
        self.description = description
        self.image = image
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case image
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self, forKey: .name)
        description = try? values.decode(String.self, forKey: .description)
        image = try? values.decode(String.self, forKey: .image)
    }
}
