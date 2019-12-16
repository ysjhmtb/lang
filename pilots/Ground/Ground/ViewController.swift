//
//  ViewController.swift
//  Ground
//
//  Created by yun on 2019/12/16.
//  Copyright © 2019 Yun. All rights reserved.
//

import UIKit
/*
 let imageName = "yourImage.png"
 let image = UIImage(named: imageName)
 let imageView = UIImageView(image: image!)
 imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
 self.view.addSubview(imageView)
 //Imageview on Top of View
 self.view.bringSubview(toFront: imageView)
 */
class ViewController: UIViewController {
    
    var lastPoint: CGPoint!
    var marker:CGRect = CGRect(x: 3, y: 66, width: 20, height: 20)
    var marker2:UIImageView?
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.addRect(marker)
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        lastPoint = CGPoint(x: 3, y: 66)
        
        let imageName = "marker.png"
        let image = UIImage(named:imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 3, y: 130, width: 20, height: 20)
        marker2 = imageView
        imgView.addSubview(marker2!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        var currPoint = touch.location(in: imgView)
        
        if(currPoint.x < 3){
            currPoint.x = 3
        }else if(330 < currPoint.x){
            currPoint.x = 330
        }
        
        if(50 < currPoint.y && currPoint.y < 80){
            UIGraphicsBeginImageContext(imgView.frame.size)
            let context = UIGraphicsGetCurrentContext()!
            
            context.setLineWidth(2.0)
            context.setStrokeColor(UIColor.red.cgColor)
           
            marker = CGRect(x: currPoint.x, y: 66, width: 20, height:20)
            
            
            lblText.text = "x : \(currPoint.x) , y : \(currPoint.y)"
            context.addRect(marker)
            context.strokePath()
            
            imgView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            lastPoint = currPoint
        }
        
        if(120 < currPoint.y && currPoint.y < 140){
            let imageName = "marker.png"
            let image = UIImage(named:imageName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: currPoint.x, y: 130, width: 20, height: 20)
            marker2 = imageView
            imgView.addSubview(marker2!)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
    }


}

