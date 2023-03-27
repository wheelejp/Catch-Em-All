//
//  Creature.swift
//  CatchEmAll
//
//  Created by Jonathan Wheeler Jr. on 3/13/23.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case url
    }
}
