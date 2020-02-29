//
//  Concentration.swift
//  Concentration
//
//  Created by Евгений Трофимов on 10/02/2020.
//  Copyright © 2020 Евгений Трофимов. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = Array<Card>()
    
    var cardsPairsAmount: Int
    
    private  var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
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
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // no cards or two cards are faced up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func restartGame() {
        cards.removeAll()
        for _ in 0..<cardsPairsAmount {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
        indexOfOneAndOnlyFaceUpCard = nil
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
