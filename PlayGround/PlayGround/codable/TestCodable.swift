//
//  testCodable.swift
//  PlayGround
//
//  Created by Yu Song on 2020-02-03.
//  Copyright © 2020 Yu Song. All rights reserved.
//

import UIKit

class TestCodable: NSObject {
    static let jsonString = """
    [
        {
            "name": "Taylor Swift",
            "age": 26
        },
        {
            "name": "Justin Bieber",
            "age": 25
        },
        {
            "name": "Yu Song",
            "age": 37
        },
        {
            "name": "Luca Song",
            "age": 4
        },
        {
            "name": "Liam",
            "age": 2
        },
        {
            "name": "Ding Dang",
            "age": 80
        }
    ]
    """

    struct Person: Codable {
        var name: String
        var age: Int
    }
    
    static func decode() -> [Person]? {
        let jsonData = Data(jsonString.utf8)
        let decoder = JSONDecoder()

        do {
            let people = try decoder.decode([Person].self, from: jsonData)
            print(people)
            return people
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
