//
//  LSPTriangleLayer.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPTriangleLayer: CAShapeLayer {
    
    let paddingSpace: CGFloat = 30.0
    
    override init() {
        super.init()
        fillColor = LSPColor_HexStr("#FDD181").cgColor
        strokeColor = LSPColor_HexStr("#FDD181").cgColor
        lineWidth = 7.0
        lineCap = CAShapeLayerLineCap.round
        lineJoin = CAShapeLayerLineJoin.round
        path = smallTrianglePath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var smallTrianglePath: UIBezierPath {
        let smallPath = UIBezierPath()
        smallPath.move(to: CGPoint(x: 5.0 + paddingSpace, y: 95.0))
        smallPath.addLine(to: CGPoint(x: 50.0, y: 12.5 + paddingSpace))
        smallPath.addLine(to: CGPoint(x: 95.0 - paddingSpace, y: 95.0))
        smallPath.close()
        return smallPath
    }
    
    var leftTrianglePath: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + paddingSpace))
        trianglePath.addLine(to: CGPoint(x: 95.0 - paddingSpace, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var rightTrianglePath: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5 + paddingSpace))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    var topTrianglePath: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0, y: 95.0))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5))
        trianglePath.addLine(to: CGPoint(x: 95.0, y: 95.0))
        trianglePath.close()
        return trianglePath
    }
    
    /**
     triangle animate function
     */
    func triangleAnimate() {
         // left
        let triangleAnimationLeft: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationLeft.fromValue = smallTrianglePath.cgPath
        triangleAnimationLeft.toValue = leftTrianglePath.cgPath
        triangleAnimationLeft.beginTime = 0.0
        triangleAnimationLeft.duration = 0.3
         // right
        let triangleAnimationRight: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationRight.fromValue = leftTrianglePath.cgPath
        triangleAnimationRight.toValue = rightTrianglePath.cgPath
        triangleAnimationRight.beginTime = triangleAnimationLeft.beginTime + triangleAnimationLeft.duration
        triangleAnimationRight.duration = 0.25
         // top
        let triangleAnimationTop: CABasicAnimation = CABasicAnimation(keyPath: "path")
        triangleAnimationTop.fromValue = rightTrianglePath.cgPath
        triangleAnimationTop.toValue = topTrianglePath.cgPath
        triangleAnimationTop.beginTime = triangleAnimationRight.beginTime + triangleAnimationRight.duration
        triangleAnimationTop.duration = 0.20
         // group
        let triangleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        triangleAnimationGroup.animations = [triangleAnimationLeft, triangleAnimationRight, triangleAnimationTop]
        triangleAnimationGroup.duration = triangleAnimationTop.beginTime + triangleAnimationTop.duration
        triangleAnimationGroup.fillMode = CAMediaTimingFillMode.forwards
        triangleAnimationGroup.isRemovedOnCompletion = false
        add(triangleAnimationGroup, forKey: nil)
    }
}
