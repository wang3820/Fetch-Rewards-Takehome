//
//  Item.swift
//  Fetch Rewards Take Home Assignment
//
//  Created by Tong Wang on 2/1/23.
//

import Foundation
import SwiftUI

struct Item: Codable, Identifiable {
    let id:Int
    let listId:Int
    let name:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case listId
        case name
    }
}

extension Item {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        listId = try values.decode(Int.self, forKey: .listId)
        
        // If the name field is null in JSON, the name field will be parsed as empty string
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
