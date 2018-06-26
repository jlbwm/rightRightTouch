//
//  ViewController.swift
//  Right Right Touch
//
//  Created by Jason on 2018/6/23.
//  Copyright © 2018年 Jiaxin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = RightRightTouch(numberOfPairsOfCards: cardButtons.count / 2)
    
    
    
   
    
    var flipCount = 0
    {
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    
    }
   
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var isDisapear: Bool = true
    
    var count : Int = 0
    
    @IBAction func touchCard(_ sender: UIButton)
    {
       
        
        if let cardNumber =  cardButtons.index(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else
        {
            print("choose wrong value")
        }
        flipCount += 1
        
        //怎么判定点击的是最后一张卡：
        // cardButtons.count = 8
        // cards = 4
        //完成updateViewFromModel()后，如果当前所有button都是faceup的，那么直接调用restart
        
        
        
        if cardCount == 10
        {
            count = 0
            
            for index in game.cards.indices
            {
                if game.cards[index].isFaceUp == true
                {
                    count += 1
                    
                }
            }
            
            
            if count == 2
            {
                restart()
            }
            
        }
        
        
        
    }
    
    @IBAction func restartGame(_ sender: UIButton)
    {
        restart()
    }
    
    var cardCount = 0
    
    func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp
            {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 1)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 0) : #colorLiteral(red: 0.9817089438, green: 0.7028414011, blue: 0.02957408503, alpha: 1)
                
                if button.backgroundColor == #colorLiteral(red: 0.9999126792, green: 1, blue: 0.9998814464, alpha: 0)
                {
                    if button.isEnabled == true
                    {
                        button.isEnabled = false
                        cardCount += 1
                       
                    }
                    
                    
                    
                    
                    
                }
            }
        }
        
        
        
    }
    
    var emojiChoices = ["💩", "💍", "👻", "🤢", "💀", "👀", "😸", "💋", "🐶"]
    
    var emoji = [Int:String]()
    
    
    
    func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0
        {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        
        return emoji[card.identifier] ?? "?"
        
    }
    
    func restart()
    {
        
        game.cards = RightRightTouch.shuffle(game.cards)//重新设计牌组
        for index in game.cards.indices
        {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        
        for index in cardButtons.indices
        {
            cardButtons[index].isEnabled = true
        }
        
        updateViewFromModel()
        
        flipCount = 0
        
        cardCount = 0
        
        count = 0
    
    }
    
   
    
    

    
    
    
    
    

}

