//
//  LSPSectionHeadView.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPSectionHeadView: UICollectionReusableView {
    
    // 图标
    let iconImg = UIImageView().then { (make) in
        make.image = UIImage(named: "mine_module")
    }
    // 标题
    let titleLbl = UILabel().then { (make) in
        make.text = "巅峰娱乐"
        make.textColor = Text59Color()
        make.font = LSPBoldFont(fontSize: 16)
    }
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 50)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 视图创建
    func setupView() {
        self.backgroundColor = mainBGColor()
        self.addSubviews(views: [iconImg,titleLbl])
        // 添加约束
        iconImg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-70, height: 30))
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImg.snp_right).offset(10)
        }
    }
}
