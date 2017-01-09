//
//  ViewController.swift
//  Fishing
//
//  Created by Nhật Minh on 11/29/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var restart_outlet: UIButton!
    
    @IBOutlet weak var exp_label: UILabel!
    
    @IBOutlet weak var timer_label: UILabel!
    
    @IBOutlet weak var WinOrLost_label: UILabel!
    
    @IBOutlet weak var level_label: UILabel!
    var fishView: FishView?
    
    var gameManager: GameManager?
    
    var fishes = 0
    
    var counter = 30
    
    var timer = Timer()
    
    var timer1 = Timer()
    
    var timer2 = Timer()
    
    var timer3 = Timer()
    
    var timer4 = Timer()
        override func viewDidLoad() {
        
        super.viewDidLoad()
            
        self.gameManager = GameManager()
            
        self.view.addSubview((self.gameManager?.hookerView)!)
            
        self.gameManager?.addFishtoviewController(viewcontroller: self, width: Int(self.view.bounds.width),fishType: 0)
            
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapHandle(_:))))
            
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(generateFish), userInfo: nil, repeats: true)
            
        timer1 =  Timer.scheduledTimer(timeInterval: 0.02, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        
        timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(firstStage), userInfo: nil, repeats: true)
            
        Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(earnExp), userInfo: nil, repeats: true)
            
        restart_outlet.isHidden = true
    }

    @IBAction func restart_btn(_ sender: UIButton) {
        
        
        
        
        
    }
    
    func tapHandle(_ sender: UIGestureRecognizer)
    {
        
        let tapPoint = sender.location(in: self.view)
        
        self.gameManager?.dropHookerAtX(x: Int(tapPoint.x))
        
    }
    
    func generateFish()
    {
        fishes += 1
        
        if fishes == 15
        {
            timer.invalidate()
        }
        
        let random = Int(arc4random_uniform(3))
        
        self.gameManager?.addFishtoviewController(viewcontroller: self, width: Int(self.view.bounds.width), fishType: random)
        
    }
    
    
    func earnExp()
    {
        
        exp_label.text = "Exp: \(self.gameManager!.exp)"
        
        
        
    }
    
    
    func firstStage()
    {
        
        counter -= 1
        
        timer_label.text = "Time: \(counter)"
        
        level_label.text = "Level 1"
        
        if counter == 0
        {
            if (self.gameManager?.exp)! < 20
            {
                
                lost()
                
            }
            else
            {
                
                counter = 30
                timer2.invalidate()
                timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondStage), userInfo: nil, repeats: true)
            }
        }
        
    }
    
    func secondStage()
    {
        
        counter -= 1
        
        timer_label.text = "Time: \(counter)"
        
        level_label.text = "Level 2"
        
        if counter == 0
        {
            if (self.gameManager?.exp)! < 50
            {
                
                lost()
                
            }
            else
            {
                
                counter = 30
                timer2.invalidate()
                timer3.invalidate()
                timer4 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(thirdStage), userInfo: nil, repeats: true)
            }
        }
        
    }
    
    func thirdStage()
    {
        counter -= 1
        
        level_label.text = "Level 3"
        
        timer_label.text = "Time: \(counter)"
        
        if counter == 0
        {
            if (self.gameManager?.exp)! < 100
            {
                
                lost()
                
            }
            else
            {
                
                won()
                
            }
        }
    }
    
    func lost()
    {
        stopEverything()
        WinOrLost_label.text = "YOU LOST :("
    }
    
    
    func won()
    {
        stopEverything()
        WinOrLost_label.text = "YOU WIN !!"
    }
    
    func stopEverything()
    {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews
        {
            if (object .isKind(of: FishView.self)) || object .isKind(of: HookerView.self)
            {
                object .removeFromSuperview()
            }
        }
        timer1.invalidate()
        timer2.invalidate()
        timer3.invalidate()
        timer4.invalidate()
    }
    
   
    
}

