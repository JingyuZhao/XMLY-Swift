//
//  CVLayerView.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/4.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import UIKit

class CVLayerView: UIView {

    var pulseLayer:CAShapeLayer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let width = self.bounds.size.width
        
        //动画图层
        pulseLayer = CAShapeLayer()
        pulseLayer.bounds = CGRect.init(x: 0, y: 0, width: width, height: width)
        pulseLayer.position = CGPoint.init(x: width/2, y: width/2)
        pulseLayer.backgroundColor = UIColor.clear.cgColor
        
        //用bezierPath画一个原型
        pulseLayer.path = UIBezierPath.init(ovalIn: pulseLayer.bounds).cgPath
        //脉冲效果的颜色
        pulseLayer.fillColor = UIColor.init(r: 213, g: 54, b: 13).cgColor
        pulseLayer.opacity = 0.0
        
        //关键代码
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect.init(x: 0, y: 0, width: width, height: width)
        replicatorLayer.position = CGPoint.init(x: width/2, y: width/2)
        replicatorLayer.instanceCount = 3 // 三个复制图层
        replicatorLayer.instanceDelay = 1 //频率
        replicatorLayer.addSublayer(pulseLayer)
        self.layer.addSublayer(replicatorLayer)
        self.layer.insertSublayer(replicatorLayer, at: 0)
        
    }
    
    func starAnimation(){
        //透明度
        let opacityAnimation = CABasicAnimation.init(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0//起始值
        opacityAnimation.toValue = 0//结束值
        
        //扩散动画
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform")
        let t = CATransform3DIdentity
        scaleAnimation.fromValue = NSValue.init(caTransform3D: CATransform3DScale(t, 0, 0, 0))
        scaleAnimation.toValue = NSValue.init(caTransform3D: CATransform3DScale(t, 1, 1, 1))
        
        //给CAShapeLayer添加组合动画
        let groupAnimation = CAAnimationGroup.init()
        groupAnimation.animations = [opacityAnimation,scaleAnimation]
        groupAnimation.duration = 3
        groupAnimation.autoreverses = false
        groupAnimation.repeatCount = HUGE
        groupAnimation.isRemovedOnCompletion = false
        pulseLayer.add(groupAnimation, forKey: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
