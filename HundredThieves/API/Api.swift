//
//  Api.swift
//  HundredThieves
//
//  Created by Russell Lowry on 5/11/20.
//  Copyright © 2020 100Thieves. All rights reserved.
//

import Foundation
import Alamofire

open class Api {
    enum BaseUrls: String {
        case dev = "https://hundred-thieves.uc.r.appspot.com/api/v1"
        case russLocal = "http://Russells-MacBook-Pro-2.local:3500/api/v1"
    }

    internal static var basePath = BaseUrls.dev.rawValue
    private static var apiSecret = "UE9tCaxtgBKXNSsagEds9GcqGYaqvdfs9DEsWXKvCtmvnFxdxPj1S3iQeDNKp99e5"
    internal static var headers = HTTPHeaders(["authorization": "Bearer \(apiSecret)"])
}
