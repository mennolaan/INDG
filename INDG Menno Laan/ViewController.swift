//
//  ViewController.swift
//  INDG Menno Laan
//
//  Created by menno laan on 04/09/16.
//  Copyright © 2016 menno laan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var btnKittenvsAI: UIButton!
  
    @IBOutlet var btnKittenvsKitten: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AI"
        {
            Game.sharedInstance.UseAI=true
        }
    }

}

