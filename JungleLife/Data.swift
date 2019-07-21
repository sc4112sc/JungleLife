//
//  Data.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/7/3.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import Foundation

struct UserInformation {
    var name: String
    var score: String
    var id: String
    var level: String
   
    
    init?(json: [String : Any]) {
        guard let name = json["Name"] as? String,
            let score = json["Score"] as? String,
            let id = json["Id"] as? String,
            let level = json["Level"] as? String
        
            
        else {
            return nil
        }
        self.name = name
        self.score = score
        self.id = id
        self.level = level
        
    }
    
}
