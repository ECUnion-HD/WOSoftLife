//
//  LSPLaunchModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPLaunchModuleVC: LSPBaseModuleVC ,LSPAnimationViewDelegate {
    
    var backImg: UIImageView!
    var animationView = LSPAnimationView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        backImg = UIImageView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height))
        backImg.image = UIImage(named: "LaunchImage")
        backImg.alpha = 0.4
        self.view.addSubview(backImg)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimationView()
    }
    
    func addAnimationView() {
        let size: CGFloat = 100.0
        let aniX: CGFloat = (self.view.width - size)/2
        let aniY: CGFloat = (self.view.height - size)/2
        animationView.frame = CGRect(x: aniX, y: aniY, width: size, height: size)
        animationView.parentFrame = view.frame
        animationView.delegate = self
        view.addSubview(animationView)
    }
    
    // MARK: SCAnimationViewDelegate
    func completeAnimation() {
        backImg.removeFromSuperview()
        view.backgroundColor = mainColor()
        // 1、动画完成自动进入主界面
        turnToMainVC()
        
        // 2、添加欢迎标语，手动点击进入主界面
        /*
        let label: UILabel = UILabel(frame: view.frame)
        label.textColor = mainColor()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 50.0)
        label.textAlignment = NSTextAlignment.center
        label.text = "Welcome-欢迎"
        label.transform = label.transform.scaledBy(x: 0.25, y: 0.25)
        view.addSubview(label)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
            label.transform = label.transform.scaledBy(x: 4.0, y: 4.0)
        }) { (finished) in
            self.addTouchButton()
        }
        */
    }
    
    func addTouchButton() {
        let button = UIButton()
        button.frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
        button.addTarget(self, action: #selector(turnToMainVC), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func turnToMainVC() {
        view.backgroundColor = .white
        view.subviews.forEach { (
            $0.removeFromSuperview()
        )}
        animationView = LSPAnimationView(frame: CGRect.zero)
        // 初始化主界面
        let mainVC = LSPMainTabBarMoudleVC()
        LSPKeyWindow?.rootViewController = mainVC
    }

}
