//
//  RightRightToch.swift
//  Right Right Touch
//
//  Created by Jason on 2018/6/23.
//  Copyright © 2018年 Jiaxin Li. All rights reserved.
//

import Foundation


class RightRightTouch
{
    //var cards = Array<Card>()
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int)
    {
        if !cards[index].isMatched //如果选中的卡不match, matched已经被设成透明不处理
        {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
                //如果已经有一张卡且不是他自己
                
                if cards[index].identifier == cards[matchIndex].identifier
                {
                    //如果两张卡序号相同,
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else
            {
                //如果先前没有选中的卡，或者两张卡不match
                for filpDownIndex in cards.indices
                {
                    cards[filpDownIndex].isFaceUp = false //将所有的卡片全部返过来
                }
                indexOfOneAndOnlyFaceUpCard = index //将当前序号给选中的卡
                cards[index].isFaceUp = true
                
            }
        }
        
        
    }
    
    static func shuffle(_ array: Array<Card>) -> Array<Card>
    {
        var list = array
        for index in 0..<array.count
        {
            let newIndex = Int(arc4random_uniform(UInt32(list.count-index))) + index
            if index != newIndex
            {
                list.swapAt(index, newIndex)
            }
        }
        return list
    }
    
   
    
    init(numberOfPairsOfCards: Int)
    {
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card] 
            
        }
        
        cards = RightRightTouch.shuffle(cards)
        
        
        
    }
}
