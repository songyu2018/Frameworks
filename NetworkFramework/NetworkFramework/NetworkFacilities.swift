//
//  NetworkFacilities.swift
//  NetworkFramework
//
//  Created by Yu Song on 2019-03-05.
//  Copyright © 2019 yusong. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum DataTaskState: String {
    case undefined = "Undefined"
    case active = "Active"
    case suspended = "Suspended"
    case cancelled = "Cancelled"
}

public class ResponseResult {
    public enum Error: Swift.Error {
      case unknownAPIResponse
      case generic
      case invalidURL
      case discarded
    }
    
    public var response: Any?
    public var error: Error?
    public var url: String?
    public var method: HTTPMethod?
    public var carrier: Any?
}

public protocol NetworkFacilities {
    var extra_resonse_delay_milliseconds: Int {get set} // add an extra delay onto response time for
    var dataTaskState: DataTaskState {get set}
    func dataTask(method: HTTPMethod, sURL: String, headers dictHeaders: Dictionary<String, String>?, body dictBody: Dictionary<String, Any>?, completion: @escaping (Bool, ResponseResult) -> ())
    init(dataTaskState: DataTaskState, extra_resonse_delay_milliseconds: Int)
}


public extension NetworkFacilities {
    func dataTask(method: HTTPMethod, sURL: String, headers dictHeaders: Dictionary<String, String>?, body dictBody: Dictionary<String, Any>?, completion: @escaping (Bool, ResponseResult) -> ()) {
        let responseObject = ResponseResult()
        responseObject.method = method
        responseObject.url = sURL
        responseObject.carrier = self
        
        //var dictResponse: [String:Any] = ["__REQUEST__": ["URL": sURL, "METHOD": method.rawValue], "__CARRIER__": self]
        if let url = URL(string: sURL) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            var dictHeaders: [String:String] = dictHeaders ?? [:]
            let contentType = dictHeaders["content-type"]
            if contentType == nil {
                dictHeaders["content-type"] = "application/json"
            }
            for (httpHeaderField, value) in dictHeaders {
                request.addValue(value, forHTTPHeaderField: httpHeaderField)
            }
            if (dictBody != nil) && (dictBody!.count > 0) {
                request.httpBody = try! JSONSerialization.data(withJSONObject: dictBody!, options: [])
            }
            
            _ = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
                DispatchQueue.main.asyncAfter(deadline: (.now() + .milliseconds(self.extra_resonse_delay_milliseconds)), execute: {
                    if self.dataTaskState == .active {
                        if let _ = urlResponse,
                            let data = data,
                            let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                            responseObject.response = jsonData
                            completion(true, responseObject)
                        } else {
                            responseObject.error = ResponseResult.Error.generic
                            completion(false, responseObject)
                        }
                    }
                    else {
                        print("Response discarded due to data task state(\(self.dataTaskState.rawValue)).")
                        // suspended or cancelled, does not expect responding
                        responseObject.error = ResponseResult.Error.discarded
                        completion(false, responseObject)
                    }
                })}.resume()
        }
        else {
            responseObject.error = ResponseResult.Error.invalidURL
            completion(false, responseObject)
        }
    }
}
