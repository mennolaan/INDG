//
//  GameController.swift
//  INDG Menno Laan
//
//  Created by menno laan on 04/09/16.
//  Copyright © 2016 menno laan. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    @IBOutlet var btn1Bamboo: CustomButton!
    @IBOutlet var btn2Bamboo: CustomButton!
    @IBOutlet var btn3Bamboo: CustomButton!
    @IBOutlet var btnStart: CustomButton!
    @IBOutlet var player1: UIButton!
    @IBOutlet var player2: UIButton!
    @IBOutlet var btnMenu: CustomButton!
    @IBOutlet var ShowPlayerTurnMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DrawBamboo(Game.sharedInstance.BambooStock)
        self.SetMessage("Don't take the last one! Computer will decide wich player goes first.")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func startTapped(sender : AnyObject) {
        StartGame()
    }
    
    @IBAction func BambooSelected1(sender: AnyObject) {
        BambooGrab(1)
    }
    @IBAction func BambooSelected2(sender: AnyObject) {
        BambooGrab(2)
    }
    @IBAction func BambooSelected3(sender: AnyObject) {
        BambooGrab(3)
    }
    
    func StartGame()
    {
        self.btnMenu.hidden=true
        self.player1.layer.removeAllAnimations()
        self.player2.layer.removeAllAnimations()
        self.btnStart.hidden=true 
        Game.sharedInstance.StartNewGame()
        BambooGrow(Game.sharedInstance.BambooStock)
        ShowPlayerTurn()
    }
    
    func ShowPlayerTurn()
    {
        
        self.player1.enabled=false
        self.player2.enabled=false
        self.EnableButton()
        self.AnimatePanda(Game.sharedInstance.PlayerTurn.ID)
        if(Game.sharedInstance.PlayerTurn.ID==0)
        {
            self.player1.enabled=true
        }
        else
        {
            self.player2.enabled=true
        }
       
        self.ShowWinner()       
    }
    
    func SetMessage(Message:String)
    {
        self.ShowPlayerTurnMessage.text = Message
    }
    
    func AnimatePanda(PlayerID: Int)
    {
        self.player1.layer.removeAllAnimations()
        self.player2.layer.removeAllAnimations()
        UIView.animateWithDuration(0.5, delay: 0.3, options: [UIViewAnimationOptions.Repeat, UIViewAnimationOptions.CurveEaseOut, UIViewAnimationOptions.Autoreverse], animations: {
        if(PlayerID == 0)
        {
            self.player1.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }
        else
        {
            self.player2.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }
        }, completion: { (Bool) -> Void in
               self.player1.transform = CGAffineTransformMakeScale(1, 1)
               self.player2.transform = CGAffineTransformMakeScale(1, 1)
        })
    }
    
    func ShowWinner()
    {
        if(Game.sharedInstance.BambooStock==0)
        {
            self.btnStart.hidden=false
            self.btnMenu.hidden=false
            self.btnStart.setTitle( "Replay" , forState: UIControlState.Normal )
            self.DisableButtons()
            self.SetMessage(Game.sharedInstance.PlayerTurn.Name + " " + "is the winner!")
            
        }
        else
        {
            self.SetMessage(Game.sharedInstance.PlayerTurn.Name + " " + "Choose")
            self.MakeAiMove()
        }
    }
    
    func MakeAiMove()
    {
        if(Game.sharedInstance.PlayerTurn.AI)
        {
            let seconds = 2.0
            let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.BambooGrab(AI.sharedInstance.MakeMove())
            })
        }
    }
    
    func DisableButtons()
    {
        self.btn1Bamboo.enabled = false
        self.btn2Bamboo.enabled = false
        self.btn3Bamboo.enabled = false
    }
    
    func BambooGrab(amount:Int)
    {
        self.DisableButtons()
        
        Game.sharedInstance.RemoveBamboo(amount)
       
        for intRemoveBambo in (Game.sharedInstance.BambooStock+1..<Game.sharedInstance.BambooStockPrevious+1).reverse()
        {
            let delayHide = 0.2 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
            let dispatchTimeHide = dispatch_time(DISPATCH_TIME_NOW, Int64(delayHide))
                
            dispatch_after(dispatchTimeHide, dispatch_get_main_queue(), {
                self.BambooHide(intRemoveBambo)
            })
        }
        
        let delayShowTurn = 1.3 * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTimeShowTurn = dispatch_time(DISPATCH_TIME_NOW, Int64(delayShowTurn))
            
        dispatch_after(dispatchTimeShowTurn, dispatch_get_main_queue(), {
            self.ShowPlayerTurn()
        })
    }
    
    func EnableButton()
    {
        
        switch(Game.sharedInstance.BambooStock) {
        case 1 :
             self.btn1Bamboo.enabled = true
                break;
        case 2 :
            self.btn1Bamboo.enabled = true
            self.btn2Bamboo.enabled = true
                break;
        default:
            self.btn1Bamboo.enabled = true
            self.btn2Bamboo.enabled = true
            self.btn3Bamboo.enabled = true
            break;
        }
    }
    
    
    func DrawBamboo(amount: Int)
    {
        let screenBounds = UIScreen.mainScreen().bounds
        let width = screenBounds.width
        let height = screenBounds.height
        
        let startX = width / 4
        let imageWidth = (width / 2 ) / 20
        
        let imageY = height / 3
        for indexBamboo in (0..<amount)
        {
            var imageView : UIImageView
            imageView  = UIImageView(frame:CGRectMake(startX + (CGFloat(indexBamboo) * imageWidth), imageY, imageWidth, 95));
            imageView.image = UIImage(named:"bamboo.png")
            imageView.tag=indexBamboo + 1
            imageView.alpha = 0.0
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageView.clipsToBounds = true
           // imageView.backgroundColor = UIColor.redColor()
            self.view.addSubview(imageView)
        }
    }
    
    func BambooGrow(bambootag:Int)
    {
        for indexBamboo in (0..<bambootag)
        {
        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.view.viewWithTag(indexBamboo+1)!.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func BambooHide(bambootag:Int)
    {
        UIView.animateWithDuration(0.2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.view.viewWithTag(bambootag)!.alpha = 0.0
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
