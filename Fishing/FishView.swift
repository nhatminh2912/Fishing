//
//  FishView.swift
//  Fishing
//
//  Created by Nhật Minh on 11/29/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    
    var size: Int?
    let SMALL : Int = 0
    let MEDIUM : Int = 1
    let LARGE : Int = 2
    var status : Int?
    var speed : Int?
    var vy : Int?
    var widthFrame : Int?
//    var heightFrame : Int?
    var widthFish : Int?
    var heightFish : Int?
    let MOVING : Int = 0
    let CAUGHT : Int = 1

    override init(frame: CGRect)
    {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateFish(width: Int, imageName: String)
        // thêm cá gốc
    {
        
        self.widthFrame = width
        
        self.vy = Int(arc4random_uniform(3)) - 1 // xem cá bơi lên, xuống hay ngang
        
        let y : CGFloat = CGFloat(arc4random_uniform(350)) + 200 // random ra vị trí cá xuất hiện
        
        self.status = MOVING
        
        self.speed = (Int)(arc4random_uniform(5)) + 2
        
        if (Int(self.center.x) <= -Int(self.widthFish!/2))
        {
            
            self.transform = CGAffineTransform.identity
            self.image = UIImage(named: imageName)
            self.frame = CGRect(x: -CGFloat(self.widthFish!), y: y, width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
            
            
        }
        else // cá đi ra ngoài mép
        {
            
            self.transform = CGAffineTransform.identity
            self.image = UIImage(cgImage: UIImage(named: imageName)!.cgImage!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
            self.frame = CGRect(x: CGFloat(self.widthFrame! + self.widthFish!), y: CGFloat(y), width: CGFloat(self.widthFish!), height: CGFloat(self.heightFish!))
            self.speed = -Int(self.speed!)
            
        }
    }
    
    func updateMove()
    {
        if (self.status == MOVING) // cá đang di chuyển
        {
            
            self.center = CGPoint(x: self.center.x + CGFloat(self.speed!), y: self.center.y + CGFloat(self.vy!))
            
            if (Int(self.center.y)) - 200 < -Int(self.heightFish!)  || Int(self.center.y) > self.heightFish! + 380
                // nếu cá đi qua mép trên hoặc mép dưới màn hình thì quay ngược lại
            {
                
                self.vy = -self.vy!
                
            }
            
            if ((Int(self.center.x) > self.widthFrame! && self.speed! > 0 ) || (Int(self.center.x) < -self.widthFish! && self.speed! < 0))
                // nếu cá đi qua mép trái hoặc mép phải màn hình thì gọi thêm 1 con
            {
                
                let random = Int(arc4random_uniform(3))
                
                if random == 0
                
                {
                    self.size = SMALL
                    generateFish(width: self.widthFrame!, imageName: "fish1" )

                }
                else if random == 1
                    
                {
                    self.size = MEDIUM
                    generateFish(width: self.widthFrame!, imageName: "fish2")
        
                }
                else
                    
                {
                    self.size = LARGE
                    generateFish(width: self.widthFrame!, imageName: "fish3")
                    
                }
            }
            
        }
        
        else if (self.status == CAUGHT) // cá cắn câu
        {
            self.center = CGPoint(x: self.center.x, y: self.center.y - 5)
            
            if (Int(self.center.y) < self.widthFish!)
            {
                
                generateFish(width: self.widthFrame!, imageName: "fish1")
                
            }
        }
        
    }
    func caught() // xoay cá lúc cắn câu
    {
        
        if (self.status == MOVING)
        {
            self.status = CAUGHT
            
            if (self.speed! > 0)
            {
                
                self.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
                
            }
                
            else
            {
                
                self.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                
            }
        }
        
    }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
}


