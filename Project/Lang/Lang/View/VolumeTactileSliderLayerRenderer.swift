//
//  VolumeTactileSliderLayerRenderer.swift
//  Lang
//
//  Created by yun on 2020/01/10.
//  Copyright © 2020 Yun. All rights reserved.
//

import UIKit

class VolumeTactileSliderLayerRenderer {
        weak var tactileSlider: VolumeTactileSlider?
        
        var trackBackground: UIColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1) {
            didSet {
                trackLayer.backgroundColor = trackBackground.cgColor
            }
        }
        
        var thumbTint: UIColor = UIColor(red: 70/255.0, green: 101/255.0, blue: 147/255.0, alpha: 1) {
            didSet {
                thumbLayer.fillColor = thumbTint.cgColor
            }
        }
        
        var cornerRadius: CGFloat = 10 {
            didSet {
                updateMaskLayerPath()
            }
        }
        
        var grayedOut: Bool = false {
            didSet {
                updateGrayedOut()
            }
        }
        
        var popUp: Bool = false {
            didSet(oldValue) {
                if oldValue != popUp {
                    updatePopUp()
                }
            }
        }
        
        let trackLayer = CALayer()
        let thumbLayer = CAShapeLayer()
        let maskLayer = CAShapeLayer()
        
        init() {
    //        print("TactileSliderLayerRenderer init")
            trackLayer.backgroundColor = trackBackground.cgColor
            thumbLayer.fillColor = thumbTint.cgColor
            maskLayer.fillColor = UIColor(red: 70/255.0, green: 101/255.0, blue: 147/255.0, alpha: 1).cgColor
            maskLayer.backgroundColor = UIColor.clear.cgColor
            trackLayer.mask = maskLayer
            trackLayer.masksToBounds = true
            trackLayer.zPosition = -0.5
            thumbLayer.zPosition = -0.5
            maskLayer.zPosition = -0.5
        }
        
        private func updateThumbLayerPath() {
    //        print("TactileSliderLayerRenderer updateThumbLayerPath")
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            thumbLayer.path = CGPath(rect: CGRect(x: 0, y: 0, width: thumbLayer.bounds.width, height: thumbLayer.bounds.height), transform: nil)
            
            CATransaction.commit()
        }
        
        private func updateMaskLayerPath() {
    //        print("TactileSliderLayerRenderer updateMaskLayerPath")
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            let maskRect = CGRect(x: 0, y: 0, width: maskLayer.bounds.width, height: maskLayer.bounds.height)
            let maskPath = UIBezierPath(roundedRect: maskRect, cornerRadius: cornerRadius)
            maskLayer.path = maskPath.cgPath
            
            CATransaction.commit()
        }
        
        private func updateGrayedOut() {
    //        print("TactileSliderLayerRenderer updateGrayedOut") // 안 나타남
            let alpha: Float = grayedOut ? 0.25 : 1
            trackLayer.opacity = alpha
        }
        
        private func updatePopUp() {
    //        print("TactileSliderLayerRenderer updatePopUp") // 안 나타남
            CATransaction.begin()
            CATransaction.setDisableActions(true)

            let zPosition: CGFloat = popUp ? 1.025 : 1
            print("before")
            dump(trackLayer)
            trackLayer.transform = CATransform3DScale(CATransform3DIdentity, zPosition, zPosition, zPosition)
            print("after")
            dump(trackLayer)

            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animation.duration = 0.1
            trackLayer.add(animation, forKey: nil)
            
            CATransaction.commit()
        }
        
        internal func updateBounds(_ bounds: CGRect) {
    //        print("TactileSliderLayerRenderer updateBounds")
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            trackLayer.bounds = bounds
            trackLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
            
            maskLayer.bounds = trackLayer.bounds
            maskLayer.position = trackLayer.position
            updateMaskLayerPath()
            
            thumbLayer.bounds = trackLayer.bounds
            thumbLayer.position = trackLayer.position
            updateThumbLayerPath()
            
            CATransaction.commit()
            
            if let value = tactileSlider?.value {
                setValue(value)
            }
        }
        
        internal func setValue(_ value: Float, animated: Bool = false) {
    //        print("TactileSliderLayerRenderer setValue")
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            let valueAxisOffset = tactileSlider!.valueAxisFrom(CGPoint(x: thumbLayer.bounds.width, y: thumbLayer.bounds.height), accountForDirection: true)
            let valueAxisAmount = tactileSlider!.positionForValue(value)
            let reverseOffset = (tactileSlider!.reverseValueAxis && !tactileSlider!.vertical) || (!tactileSlider!.reverseValueAxis && tactileSlider!.vertical)
            let position = tactileSlider!.pointOnSlider(valueAxisPosition: valueAxisAmount - (reverseOffset ? 0 : valueAxisOffset), offAxisPosition: 0)
            
            thumbLayer.transform = CATransform3DTranslate(CATransform3DIdentity, position.x, position.y, 0)
            
            if animated {
                let animationAxis = tactileSlider!.vertical ? "y" : "x"
                let animation = CABasicAnimation(keyPath: "transform.translation.\(animationAxis)")
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
                thumbLayer.add(animation, forKey: nil)
            }
            
            CATransaction.commit()
        }
}
