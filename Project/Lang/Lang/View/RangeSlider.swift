//
//  RangeSlider.swift
//  Lang
//
//  Created by yun on 2019/12/31.
//  Copyright © 2019 Yun. All rights reserved.
//

import UIKit

class RangeSlider: UIControl {
    
  override var frame: CGRect {
    didSet {
        updateLayerFrames()
    }
  }
    
  var minimumValue: CGFloat = 0 {
    didSet {
      updateLayerFrames()
    }
  }

  var maximumValue: CGFloat = 1 {
    didSet {
      updateLayerFrames()
    }
  }

  var lowerValue: CGFloat = 0.2 {
    didSet {
      updateLayerFrames()
    }
  }

  var upperValue: CGFloat = 0.8 {
    didSet {
      updateLayerFrames()
    }
  }

  var trackTintColor = UIColor(red: 210/255.0, green: 210/255.0, blue: 210/255.0, alpha: 1) {
    didSet {
      trackLayer.setNeedsDisplay()
    }
  }

    var trackHighlightTintColor = UIColor(red: 59/255.0, green: 185/255.0, blue: 185/255.0, alpha: 0.71) {
    didSet {
      trackLayer.setNeedsDisplay()
    }
  }

  var thumbImageA =  #imageLiteral(resourceName: "APointer") {
    didSet {
      lowerThumbImageView.image = thumbImageA
      updateLayerFrames()
    }
  }

  var thumbImageB = #imageLiteral(resourceName: "BPointer") {
    didSet {
        upperThumbImageView.image = thumbImageB
        updateLayerFrames()
    }
  }
    
  var highlightedThumbImageA =  #imageLiteral(resourceName: "APointer") {
    didSet {
      lowerThumbImageView.highlightedImage = highlightedThumbImageA
      updateLayerFrames()
    }
  }

  var highlightedThumbImageB = #imageLiteral(resourceName: "BPointer") {
    didSet {
      upperThumbImageView.highlightedImage = highlightedThumbImageB
      updateLayerFrames()
    }
  }

  private var previousLocation = CGPoint()
    
  // var thumbImage = #imageLiteral(resourceName: "Oval")
  // private let trackLayer = CALayer()
  private let trackLayer = RangeSliderTrackLayer()
  private let lowerThumbImageView = UIImageView()
  private let upperThumbImageView = UIImageView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    trackLayer.rangeSlider = self
        // contentsScale: CGFloat - The scale factor applied to the layer.
        // scale: CGFloat - The natural scale factor associated with the screen.
    trackLayer.contentsScale = UIScreen.main.scale
        // UIControl -> UIView -> layer
    layer.addSublayer(trackLayer)
    
    lowerThumbImageView.image = thumbImageA
    addSubview(lowerThumbImageView)
    
    upperThumbImageView.image = thumbImageB
    addSubview(upperThumbImageView)
   
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  // 1
  private func updateLayerFrames() {
        // insetBy(dx:dy:) - Returns a rectangle that is smaller or larger
        //                   than the source rectangle, with the same center point.
    trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
    trackLayer.setNeedsDisplay()
    lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                       size: thumbImageA.size)
    upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                       size: thumbImageB.size)
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    CATransaction.commit()

  }
  // 2
  func positionForValue(_ value: CGFloat) -> CGFloat {
        // bounds.widht의 %, 0.2면 20%
    return bounds.width * value
  }
  // 3
  private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
    let x = positionForValue(value) - thumbImageA.size.width / 2.0
    return CGPoint(x: x, y: (bounds.height * 0.001 - thumbImageA.size.height) / 2.0)
  }
}

extension RangeSlider {
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    // 1
    previousLocation = touch.location(in: self)
    
    // 2
    if lowerThumbImageView.frame.contains(previousLocation) {
      lowerThumbImageView.isHighlighted = true
    } else if upperThumbImageView.frame.contains(previousLocation) {
      upperThumbImageView.isHighlighted = true
    }
    
    // 3
    return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
  }
    
  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let location = touch.location(in: self)
      
    // 1 결국 비율 즉, 소수점을 더하게 된다.
    let deltaLocation = location.x - previousLocation.x
    let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
      
    previousLocation = location
      
    // 2
    if lowerThumbImageView.isHighlighted {
        lowerValue += deltaValue
        lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                upperValue: upperValue)
        
      } else if upperThumbImageView.isHighlighted {
        upperValue += deltaValue
        upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                upperValue: maximumValue)
      }
    // 데이터 보내기
    sendActions(for: .valueChanged)

    return true
  }

  // 4
  private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat,
                            upperValue: CGFloat) -> CGFloat {
        // min( max(0.21, 0), 0.8) -> 0.21
        // min( max(0.79, 0.21), 1) -> 0.79
    return min(max(value, lowerValue), upperValue)
  }
    
  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // A Boolean value that determines whether the image is highlighted.
    lowerThumbImageView.isHighlighted = false
    upperThumbImageView.isHighlighted = false
  }
}

