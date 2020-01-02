//
//  RangeSliderTrackLayer.swift
//  Lang
//
//  Created by yun on 2019/12/31.
//  Copyright © 2019 Yun. All rights reserved.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
      
    // Draws the layer’s content using the specified graphics context.
    // ctx - The graphics context in which to draw the content.
    override func draw(in ctx: CGContext) {
      guard let slider = rangeSlider else {
        return
      }
      // 어떻게 구간이 나누어져서 색이 칠해지는지 모르겠다.
      let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      ctx.addPath(path.cgPath)
      ctx.setFillColor(slider.trackTintColor.cgColor)
      ctx.fillPath()
      ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
      let lowerValuePosition = slider.positionForValue(slider.lowerValue)
      let upperValuePosition = slider.positionForValue(slider.upperValue)
      let rect = CGRect(x: lowerValuePosition, y: 0,
                        width: upperValuePosition - lowerValuePosition,
                        height: bounds.height)
      ctx.fill(rect)
    }
}
