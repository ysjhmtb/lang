// https://www.appcoda.com/interactive-animation-uiviewpropertyanimator/

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




