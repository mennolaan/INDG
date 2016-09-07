//
//  Game.swift
//  INDG Menno Laan
//
//  Created by menno laan on 04/09/16.
//  Copyright © 2016 menno laan. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    internal var BambooStockPrevious: Int
    internal var BambooStock: Int
    internal var MinValue: Int
    internal var MaxValue: Int
    
    var UseAI = false
    var Player1 = Player()
    var Player2 = Player()
    var PlayerTurn = Player()
    
    class var sharedInstance: Game {
        struct Singleton {
            static let instance = Game()
        }
        
        return Singleton.instance
    }
    
    override init() {
        BambooStock=20
        BambooStockPrevious=BambooStock
        MinValue=1
        MaxValue=3
        super.init()
    }
    
    private func DecideStartPlayer()
    {
        // generate random number between 0 or 1 in order to decide starting player
        let random = Int(arc4random_uniform(2))
    
        if(random==0)
        {
            self.PlayerTurn = self.Player1
        }
        else
        {
            self.PlayerTurn = self.Player2
        }
    }
    
    private func SetPlayerTurn()
    {
        if(self.PlayerTurn.ID==0)
        {
            self.PlayerTurn = self.Player2
        }
        else
        {
            self.PlayerTurn = self.Player1
        }
    }
    
    func StartNewGame()
    {
        // If computer is choosen player 1 is computer
        self.Player1=Player()
        self.Player1.ID = 0
        self.Player1.Name = "Blue Panda"
        self.Player1.AI=UseAI
        
        self.Player2=Player()
        self.Player2.ID = 1
        self.Player2.Name = "Red Panda"
        
        BambooStock=20
        BambooStockPrevious=BambooStock
        
        DecideStartPlayer()
    }
    
    func RemoveBamboo(amount:Int) {
        BambooStockPrevious=BambooStock
        BambooStock-=amount
        
        self.SetPlayerTurn()
    }
}

