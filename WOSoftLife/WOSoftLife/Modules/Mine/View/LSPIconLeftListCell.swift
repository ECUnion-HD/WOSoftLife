//
//  LSPIconLeftListCell.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//  

import UIKit

class LSPIconLeftListCell: LSPBaseTableViewCell {
    
    // 左侧图标
    let iconImg = UIImageView().then { (make) in
        make.image = UIImage(named: "mine_active")
    }
    // 标题
    let titleLbl = UILabel().then({ (make) in
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // 详细
    let detailLbl = UILabel().then({ (make) in
        make.textColor = TextA4Color()
        make.textAlignment = .right
        make.font = LSPFont(fontSize: 14)
    })
    // 右箭头
    let iconArrow = UIImageView().then({ (make) in
        make.image = UIImage(named: "sc_righta")
    })
    /// 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 界面布局
    override func setupView() {
        /// 添加子视图
        self.contentView.addSubviews(views: [iconImg,titleLbl,iconArrow,detailLbl])
        /// 添加约束
        // 左侧图标
        iconImg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        // 标题
        titleLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 80, height: 55))
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImg.snp_right).offset(10)
        }
        // 右箭头
        iconArrow.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 17, height: 17))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        // 详细
        detailLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-160, height: 55))
            make.centerY.equalToSuperview()
            make.right.equalTo(iconArrow.snp_left).offset(-10)
        }
    }

    /// 数据处理
    @discardableResult
    override func setModel(model: Dictionary<String, Any>) -> CGFloat {
        iconImg.image = UIImage(named: model.getString(dic: model, key: "icon"))
        titleLbl.text = "\(model.getString(dic: model , key: "title"))"
        detailLbl.text = "\(model.getString(dic: model , key: "detail"))"
        return self.cellHeight;
    }
}
