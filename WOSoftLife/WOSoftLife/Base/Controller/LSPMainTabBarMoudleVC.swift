//
//  LSPMainTabBarMoudleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPMainTabBarMoudleVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabbar = UITabBar.appearance()
        tabbar.tintColor = mainColor()
        tabbar.barTintColor = .white
        // 添加子控制器
        addChildViewControllers()
    }
    

    /// 设置控制器
    private func setChildController(controller: UIViewController, imageName: String) {
         controller.tabBarItem.image = UIImage(named: imageName + "_nor")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_pre")
    }
    
    /// 添加子控制器
    private func addChildViewControllers() {
        setChildViewController(LSPMessageModuleVC(), title: "消息", imageName: "message")
        setChildViewController(LSPHomeModuleVC(), title: "首页", imageName: "home")
        setChildViewController(LSPNewsListIndexVC(), title: "资讯", imageName: "news")
        setChildViewController(LSPMineModuleVC(isForm: true), title: "我的", imageName: "mine")
    }
    
    /// 初始化子控制器
    private func setChildViewController(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        setChildController(controller: childController, imageName: imageName)
        childController.title = title
        // 添加导航控制器为 TabBarController 的子控制器
        addChild(LSPNavigationModuleVC(rootViewController: childController))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}
