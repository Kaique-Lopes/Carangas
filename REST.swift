//
//  REST.swift
//  Carangas
//
//  Created by Kaique Lopes on 05/04/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation

class REST {
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    } ()
    
    private static let session = URLSession(configuration: configuration)
    
    
}