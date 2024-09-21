//
//  Configuration.swift
//  foo_wallet
//
//  Created by Amena Amro on 10/11/18.
//  Copyright © 2018 FOO. All rights reserved.
//

import Foundation

class ConfigEnvironment: NSObject {
    fileprivate let config: NSDictionary
    
    static let shared = ConfigEnvironment()
        
    private init(dictionary: NSDictionary) {
        config = dictionary
    }
    
    convenience override init() {
        let bundle = Bundle.main
        let configPath = bundle.path(forResource: "config", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: configPath)!
        
        self.init(dictionary: config)
    }
}

extension ConfigEnvironment {
    var baseUrl: String {
        return config["BASE_URL"] as! String
    }
    
    var apiKey: String {
        return config["API_KEY"] as! String
    }
}
