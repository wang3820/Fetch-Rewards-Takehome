//
//  Item.swift
//  Fetch Rewards Take Home Assignment
//
//  Created by Ray on 2/1/23.
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
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}
