//
//  Item.swift
//  Avans-IOS
//
//  Created by Daan Groot on 20/03/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
