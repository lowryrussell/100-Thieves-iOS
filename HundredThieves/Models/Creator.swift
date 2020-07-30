//
//  Creator.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/7/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation

class Creator: Decodable {
    
    enum Platform: String, Codable {
        case twitch
        case youtube
        case mixer
    }
    
    enum Status: String, Codable {
        case live
        case offline
    }
    
    var name: String?
    var image: String?
    var platform: Platform?
    var status: Status?
    var channelName: String?
    var twitterHandle: String?
    var instagramHandle: String?
    
    
    init(name: String, image: String, platform: Platform, status: Status, channelName: String, twitterHandle: String, instagramHandle: String) {
        self.name = name
        self.image = image
        self.platform = platform
        self.status = status
        self.channelName = channelName
        self.twitterHandle = twitterHandle
        self.instagramHandle = instagramHandle
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case image
        case platform
        case status
        case channelName
        case twitterHandle
        case instagramHandle
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try? values.decode(String.self, forKey: .name)
        image = try? values.decode(String.self, forKey: .image)
        platform = try? values.decode(Platform.self, forKey: .platform)
        status = try? values.decode(Status.self, forKey: .status)
        channelName = try? values.decode(String.self, forKey: .channelName)
        twitterHandle = try? values.decode(String.self, forKey: .twitterHandle)
        instagramHandle = try? values.decode(String.self, forKey: .instagramHandle)
    }
}
