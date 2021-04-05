//
//  REST.swift
//  Carangas
//
//  Created by Kaique Lopes on 05/04/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class REST {
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.httpAdditionalHeaders = ["Content-type": "application/json"]
        config.httpMaximumConnectionsPerHost = 5
        return config
    } ()
    
    private static let session = URLSession(configuration: configuration)
    
    // MARK: - Method Class
    class func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
            
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                    
                }
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    }catch {
                        print(error.localizedDescription)
                        onError(.invalidJSON)
                    }
                }else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
                
            }else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
    
}
