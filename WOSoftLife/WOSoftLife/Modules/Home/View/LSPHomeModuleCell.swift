//
//  LSPHomeModuleCell.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPHomeModuleCell: UICollectionViewCell {
    
    // 背景视图
    let bgView = UIView().then { (make) in
        make.backgroundColor = .white
        make.layer.cornerRadius = 10
        make.layer.masksToBounds = true
    }
    // 图标
    let iconImg = UIImageView().then { (make) in
        make.image = UIImage(named: "mine_module")
    }
    // 标题
    let titleLbl = UILabel().then { (make) in
        make.text = "功能模块"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 14)
        make.textAlignment = .center
    }
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 界面布局
    func setupView() {
        self.contentView.backgroundColor = mainBGColor()
        self.contentView.addSubviews(views: [bgView])
        bgView.addSubviews(views: [iconImg,titleLbl])
        // 添加约束
        bgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        let imgHeight = (Screen_Width-60)/4 - 50;
        iconImg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: imgHeight, height: imgHeight))
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        titleLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: (Screen_Width-60)/4-10, height: 20))
            make.top.equalTo(iconImg.snp_bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
}
