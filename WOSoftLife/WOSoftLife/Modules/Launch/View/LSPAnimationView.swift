//
//  LSPAnimationView.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

protocol LSPAnimationViewDelegate {
    func completeAnimation()
}

class LSPAnimationView: UIView {

    let circleLayer =  LSPCircleLayer()
    let triangleLayer =  LSPTriangleLayer()
    let redRectangleLayer = LSPRectangleLayer()
    let blueRectangleLayer = LSPRectangleLayer()
    let waveLayer = LSPWaveLayer()
    var parentFrame: CGRect = CGRect.zero
    var delegate: LSPAnimationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        addCircleLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     add circle layer
     */
    func addCircleLayer() {
        self.layer.addSublayer(circleLayer)
        circleLayer.expand()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(wobbleCircleLayer), userInfo: nil, repeats: false)
    }
    
    /**
     circle layer wobble animation
     */
    @objc func wobbleCircleLayer() {
        circleLayer.wobbleAnimate()
        layer.addSublayer(triangleLayer)
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(showTriangleAnimation), userInfo: nil, repeats: false)
    }
    
    /**
     show triangle animation
     */
    @objc func showTriangleAnimation() {
        triangleLayer.triangleAnimate()
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(transformAnima), userInfo: nil, repeats: false)
    }
    
    /**
     self transform and add rectangle
     */
    @objc func transformAnima() {
        transformRotationZ()
        circleLayer.contract()
        Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(drawRedRectangleAnimation), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 0.65, target: self, selector: #selector(drawBlueRectangleAnimation), userInfo: nil, repeats: false)
    }
    
    /**
     self transform z
     */
    func transformRotationZ() {
        self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.65)
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        let doubleValue = Double.pi*2
        rotationAnimation.toValue = CGFloat(doubleValue)
        rotationAnimation.duration = 0.45
        rotationAnimation.isRemovedOnCompletion = true
        layer.add(rotationAnimation, forKey: nil)
    }
    
    /**
     draw red stroke
     */
    @objc func drawRedRectangleAnimation() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.strokeChangeWithColor(color: LSPColor_HexStr("#FDD181"))
    }
    
    /**
     draw blue stroke
     */
    @objc func drawBlueRectangleAnimation() {
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.strokeChangeWithColor(color: mainColor())
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(drawWaveAnimation), userInfo: nil, repeats: false)
    }

    @objc func drawWaveAnimation() {
        layer.addSublayer(waveLayer)
        waveLayer.animate()
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(expandView), userInfo: nil, repeats: false)
    }

    @objc func expandView() {
        backgroundColor = mainColor()
        frame = CGRect(x: frame.origin.x - blueRectangleLayer.lineWidth, y: frame.origin.y - blueRectangleLayer.lineWidth, width: frame.size.width + blueRectangleLayer.lineWidth * 2, height: frame.size.height + blueRectangleLayer.lineWidth * 2)
        layer.sublayers = nil
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.frame = self.parentFrame
        }) { (finished) in
            self.delegate?.completeAnimation()
        }
    }

}
