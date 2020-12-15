//
//  Service.swift
//  GenericCollections
//
//  Created by Mac on 15.12.2020.
//

import Foundation

protocol Service {
    var domain : String { get }
    var requestURL : String { get }
    var errorString : String { get }
}


enum ExampleService : Service {
    var domain: String {
        return "http://dummy.restapiexample.com"
    }
    
    case getData
    case exampleURL(exampleString : String)
    
    var requestURL: String {
        switch self {
        case .getData:
            return "/api/v1/employees"
        case .exampleURL(let string):
            return "/api/v1/employees" + string
        }
    }
    var errorString: String {
        return "Something went wrong"
    }
}


class ServiceLayer<T : Service> {
    init() {  }
    
    public func load<D: Codable>(service : T , decodeTo : D.Type , complition : @escaping  (D)->Void) {
        guard  let requestURL = URL(string: service.domain + service.requestURL) else {
           fatalError("invalid url string")
        }
        print(requestURL)
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
                   if let response = response {
                       let httpResponse = response as! HTTPURLResponse
                       print("URL Response : \(httpResponse.statusCode)")
                   }
                   if let _ =  err {
                    print(service.errorString)
                   }
                   if let data = data {
                            let decoder = JSONDecoder()
                            do {
                                let example = try decoder.decode(decodeTo, from: data)
                                complition(example)
                            }catch let error {
                                print (error.localizedDescription)
                            }
                   }
               }
               task.resume()
    }
}
