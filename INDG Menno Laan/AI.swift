//
//  AI.swift
//  INDG Menno Laan
//
//  Created by menno laan on 05/09/16.
//  Copyright © 2016 menno laan. All rights reserved.
//

import Foundation
class AI: NSObject {
    
    class var sharedInstance: AI {
        struct Singleton {
            static let instance = AI()
        }
        
        return Singleton.instance
    }
    
    override init() {
               super.init()
    }
    
    func MakeMove() -> Int {
        let MinValue = Game.sharedInstance.MinValue
        let MaxValue = Game.sharedInstance.MaxValue
        let EndWith = MinValue + MaxValue
        
        let ModValue = Game.sharedInstance.BambooStock % EndWith
        // modvalue
        if(ModValue == MinValue)
        {
            return MaxValue
        }
        else
        {
            return ModValue == 0 ? MaxValue : ModValue - 1
        }
    }
}
