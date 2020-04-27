//
//  NetworkWrapper.swift
//  VAManagerBuddy
//
//  Created by Vikash Anand on 22/02/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//


import Foundation
import UIKit

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask
    }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

final class NetworkWrapper {
    
    //private static let urlString = URL(string: "https://randomuser.me/api/?results=5")
    static let sharedInstance = NetworkWrapper()
    private init(){}
    
    func makeNetworkRequest<T: Decodable>(url: URL,
                                          using session: URLSessionProtocol = URLSession.shared,
                                          result: @escaping (Result<T, Error>) -> Void)
    {        
        session.dataTask(with: url) { (data, response, error) in
            
            let content = readDummyJSONResonse()!
            DispatchQueue.main.async {
                
                //                guard let content = data, error == nil else {
                //                    debugPrint(error.debugDescription)
                //                    completionHandler(Jet2TTError.badResponse, nil)
                //                    return
                //                }
                
                do {
                    let myNewObject = try JSONDecoder().decode(T.self, from: content)
                    //debugPrint(myNewObject)
                    result(.success(myNewObject))
                } catch { let error = error as NSError
                    debugPrint(error.userInfo.debugDescription)
                    debugPrint(DataFetchingError.badResponse.errorDescription!)
                    result(.failure(DataFetchingError.badResponse))
                    return
                }
            }
            }.resume()
    }
}


final class NetworkFetcher {
    
    private var photos: [VAPhoto]?
    private var photoResponse: VAResponseModel?
    private static let memberUrlString = "https://randomuser.me/api/?results=20"
    
    func fetchMembers(with completion: @escaping (Result<VAResponseModel, Error>) -> Void) {
        guard let memberURL = URL(string: type(of: self).memberUrlString) else { return }
        NetworkWrapper.sharedInstance.makeNetworkRequest(url: memberURL) { result in
            completion(result)
        }
    }
}
