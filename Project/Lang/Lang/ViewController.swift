//
//  ViewController.swift
//  Lang
//
//  Created by yun on 2019/12/25.
//  Copyright © 2019 Yun. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}
extension CGVector {
    init (_ dx:CGFloat, _ dy:CGFloat) {
        self.init(dx:dx, dy:dy)
    }
}

class ViewController: UIViewController {
        
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var controlPanel: UIView!    
    @IBOutlet weak var controlConatinerView: UIView!
    
    @IBOutlet weak var pointerALabel: UILabel!
    @IBOutlet weak var pointerBLabel: UILabel!
    
    
    // playerView에서 gradient background color
    var gradientLayer: CAGradientLayer!
    // controlContainerView 내부의 control
    let rangeSlider = RangeSlider(frame: .zero)
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = playerView.bounds
        gradientLayer.colors = [UIColor(hexString: "#385175").cgColor, UIColor(hexString: "#36a9ba").cgColor]
        gradientLayer.zPosition = -1
        playerView.layer.addSublayer(gradientLayer)
    }
    
    func createProgressView(){        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlConatinerView.addSubview(rangeSlider)
        // 드래그 이벤트에 따른 위치 정보 가져오기
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
        for: .valueChanged)
        // 구간 정보 레이블 초기화
        pointerALabel.text = rangeSlider.lowerValue.description
        pointerBLabel.text = rangeSlider.upperValue.description
                
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
       
    
    // rangeSlider의 크기와 위치
    override func viewDidLayoutSubviews() {
        
        controlPanel.layer.cornerRadius = 7.0
        createGradientLayer()
        
        let margin: CGFloat = 20
//        let width = view.bounds.width - 2 * margin
        let width = controlConatinerView.bounds.width - 2 * margin
//        let height: CGFloat = 30
        let height: CGFloat = controlConatinerView.bounds.height * 0.5
        
        rangeSlider.frame = CGRect(x: 0, y: 0, width: width, height: height)
//        rangeSlider.center = CGPoint(controlConatinerView.center.x * 0.9, controlConatinerView.center.y * 0.21)
        rangeSlider.center = CGPoint(view.center.x * 0.9, view.center.y * 0.1)
        
        
    }
    
    // 드래그 이벤트에 따른 위치 정보 가져오기
   @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
     let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
     print("Range slider value changed: \(values)")
    var aString: String = rangeSlider.lowerValue.description
    var bString: String = rangeSlider.upperValue.description
    if aString != nil && aString.count > 5{
        pointerALabel.text = nil
        let end = aString.index(aString.startIndex, offsetBy: 5)
        let range = aString.startIndex..<end
        print("String(aString[range]) \(String(aString[range]))")
        pointerALabel.text = String(aString[range])
    }
    if bString != nil && bString.count > 5{
        pointerBLabel.text = nil
        let end = bString.index(bString.startIndex, offsetBy: 5)
        let range = aString.startIndex..<end
        print("String(bString[range]) \(String(bString[range]))")
        pointerBLabel.text = String(bString[range])
    }
    
   }
}

