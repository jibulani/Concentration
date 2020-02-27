//
//  Card.swift
//  Concentration
//
//  Created by Евгений Трофимов on 10/02/2020.
//  Copyright © 2020 Евгений Трофимов. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var hashValue: Int { return identifier }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
