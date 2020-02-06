//
//  File.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-05.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import Foundation
import NetworkFramework

public enum Result<ResultType> {
  case results(ResultType)
  case error(Error)
}

class NetworkingManager: NetworkFacilities {
    
    static let shared = NetworkingManager(dataTaskState: .active, extra_resonse_delay_milliseconds: 0)
    
    var dataTaskState: DataTaskState
    var extra_resonse_delay_milliseconds: Int
    
    
    required init(dataTaskState: DataTaskState, extra_resonse_delay_milliseconds: Int) {
        self.dataTaskState = dataTaskState
        self.extra_resonse_delay_milliseconds = extra_resonse_delay_milliseconds
    }
    
    func get(url: String, completion: @escaping (Result<Any>) -> Void) {
        self.dataTask(method: .GET, sURL: url, headers: nil, body: nil) { (success, responseObject) in
            if let resultsJSON = responseObject.response {
              DispatchQueue.main.async {
                completion(Result.results(resultsJSON))
              }
            } else {
              completion(Result.error(ResponseResult.Error.generic))
            }
        }
    }
    
    // TODO: implement the other protocols.
}
