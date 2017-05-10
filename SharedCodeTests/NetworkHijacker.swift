//
//  NetworkHijacker.swift
//  memory-iOS
//
//  Created by Matt Amerige on 5/10/17.
//  Copyright © 2017 Matt Amerige. All rights reserved.
//

import Foundation
import OHHTTPStubs

class NetworkHijacker {
    func hijackDefineRequest(toHost host: String) {
        stub(condition: isHost(host)) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("mock_jp_definitioin_response.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
}
