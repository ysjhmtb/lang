//
//  ViewController.swift
//  Try1218
//
//  Created by yun on 2019/12/18.
//  Copyright © 2019 Yun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    var imgMarker:UIImage?
    var location = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgMarker = UIImage(named: "marker.png")
        imgView.image = imgMarker
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touch = touches.first {
            location = touch.location(in: self.view)
        imgView.center = location
            
        }
    }


}

