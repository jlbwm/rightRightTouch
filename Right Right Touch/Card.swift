//
//  Card.swift
//  Right Right Touch
//
//  Created by Jason on 2018/6/23.
//  Copyright © 2018年 Jiaxin Li. All rights reserved.
//

import Foundation

//构建基础的卡片结构，存有基本的卡片数据，注意：只是那张卡，印什么不管
struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        return identifierFactory
    }
    
    init()
    {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
