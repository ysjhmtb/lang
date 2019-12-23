import Foundation
import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 640.0))
XCPlaygroundPage.currentPage.liveView = containerView
containerView.backgroundColor = UIColor.white

// Drawing the borders
let sliderFrame = CGRect(x: 100, y: 30, width: 30, height: 200)
let borderLayer = CALayer()
borderLayer.frame = sliderFrame

borderLayer.backgroundColor = UIColor.white.cgColor
borderLayer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
borderLayer.borderWidth = 1
borderLayer.cornerRadius = sliderFrame.size.width / 2.0
borderLayer.masksToBounds = true

containerView.layer.addSublayer(borderLayer)

// Drawing the track
let trackLayer = CALayer()

trackLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
trackLayer.backgroundColor = UIColor.red.cgColor
trackLayer.frame = CGRect(x: 0, y: 0, width: 30, height: 80)
trackLayer.position = CGPoint(
    x: borderLayer.bounds.size.width / 2,
    y: borderLayer.bounds.size.height / 2
)
borderLayer.addSublayer(trackLayer)

// Drawing the handle
let handleLayer = CALayer()

handleLayer.position = borderLayer.position
handleLayer.bounds.size = CGSize(
    width: borderLayer.bounds.size.width,
    height: borderLayer.bounds.size.width
)
handleLayer.cornerRadius = borderLayer.bounds.size.width / 2.0
handleLayer.backgroundColor = UIColor.white.cgColor
handleLayer.shadowColor = UIColor.black.cgColor
handleLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
handleLayer.shadowRadius = 2
handleLayer.shadowOpacity = 0.3
handleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

containerView.layer.addSublayer(handleLayer)





/* https://www.appcoda.com/interactive-animation-uiviewpropertyanimator/

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
containerView.layer.borderColor = UIColor.gray.cgColor
containerView.layer.borderWidth = 1.0
containerView.backgroundColor = .white

var box = UIView(frame:CGRect(x: 0, y: 25, width: 50, height: 50))
box.backgroundColor = .green

containerView.addSubview(box)

let animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear){
    box.frame = box.frame.offsetBy(dx: 250, dy: 0)
}

animator.startAnimation()

PlaygroundPage.current.liveView = containerView


*/

