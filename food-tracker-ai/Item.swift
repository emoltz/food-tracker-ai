//
//  Item.swift
//  food-tracker-ai
//
//  Created by Ethan Shafran Moltz on 11/20/23.
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
