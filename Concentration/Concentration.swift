//
//  Concentration.swift
//  Concentration
//
//  Created by Евгений Трофимов on 10/02/2020.
//  Copyright © 2020 Евгений Трофимов. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = Array<Card>()
    
    var cardsPairsAmount: Int
    
    private  var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if (cards[index].isFaceUp) {
                    if (foundIndex == nil) {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): must be at least one pair")
        cardsPairsAmount = numberOfPairsOfCards
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // no cards or two cards are faced up
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func restartGame() {
        cards.removeAll()
        for _ in 0..<cardsPairsAmount {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        indexOfOneAndOnlyFaceUpCard = nil
    }
}