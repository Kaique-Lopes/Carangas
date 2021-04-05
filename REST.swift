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
        config.httpMaximumConnectionsPerHost = 5
        return config
    } ()
    
    private static let session = URLSession(configuration: configuration)
    
    // MARK: - Method Class
    class func loadCars() {
        guard let url = URL(string: basePath) else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    
                    guard let data = data else {return}
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        for car in cars {
                            print(car.name, car.brand)
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                }else {
                    print("Algum Status inválido pelo servidor!!")
                }
                
            }else {
                print(error!)
            }
        }
        dataTask.resume()
    }
    
}
