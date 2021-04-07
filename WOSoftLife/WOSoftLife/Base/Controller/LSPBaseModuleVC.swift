//
//  LSPBaseModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit
import SnapKit

class LSPBaseModuleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        basicStyle()
        setupView()
        bindEvent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - 基础样式
    func basicStyle() {
        view.backgroundColor = mainBGColor()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        viewAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewAppeared(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewDisAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDisAppeared(animated)
    }

}

extension LSPBaseModuleVC {
    
    /// 启动视图
    @objc func setupView() {}
    
    /// 帮顶事件
    @objc func bindEvent() {}
    
    /// 初始化加载数据
    @objc func loadData() {}
    
    /// 界面即将显示
    ///
    /// - Parameter animated: 是否动画
    @objc func viewAppear(_ animated: Bool) {}
    
    /// 界面完成显示
    ///
    /// - Parameter animated: 是否动画
    @objc func viewAppeared(_ animated: Bool) {}
   
    /// 界面即将消失
    ///
    /// - Parameter animated: 是否动画
    @objc func viewDisAppear(_ animated: Bool) {}
    
    /// 界面完成消失
    ///
    /// - Parameter animated: 是否动画
    @objc func viewDisAppeared(_ animated: Bool) {}

}
