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
        
        //当所有的牌都已经faceUp,重新开始游戏
        
    }
    
    @IBAction func restartGame(_ sender: UIButton)
    {
        restart()
    }
    
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
        
        updateViewFromModel()
        
        flipCount = 0
    }
    
    
    
    
    

}

