//
//  DataTaskProtocol.swift
//  
//
//

import Foundation

public enum DataTaskState: String {
    case undefined = "Undefined"
    case active = "Active"
    case suspended = "Suspended"
    case cancelled = "Cancelled"
}

public protocol DataTaskProtocol {
    
    var dataTaskState: DataTaskState {get set}
    
}
