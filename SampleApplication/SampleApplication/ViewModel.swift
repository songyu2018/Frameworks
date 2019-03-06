//
//  ViewModel.swift
//  CameraFramework
//
//  Created by Nicky on 2019-03-05.
//  Copyright © 2019 David Okun. All rights reserved.
//

import Foundation
import NetworkFramework

class ViewModel: NetworkFacilities {
    
    var extra_resonse_delay_milliseconds: Int
    
    var dataTaskState: DataTaskState
    
    required init(dataTaskState: DataTaskState, extra_resonse_delay_milliseconds: Int) {
        self.dataTaskState = dataTaskState
        self.extra_resonse_delay_milliseconds = extra_resonse_delay_milliseconds
    }
    
}
