//
//  LSPMessageListCell.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPMessageListCell: LSPBaseTableViewCell {
    
    // 头像
    let iconImg = UIImageView().then { (make) in
        make.layer.masksToBounds = true
        make.layer.cornerRadius = 30
        make.image = UIImage(named: "sc_head")
    }
    // 标题
    let titleLbl = UILabel().then { (make) in
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
        make.numberOfLines = 0
    }
    // 内容
    let contentLbl = UILabel().then { (make) in
        make.textColor = TextA4Color()
        make.font = LSPFont(fontSize: 13)
    }
    // 时间
    let timeLbl = UILabel().then { (make) in
        make.textColor = TextA4Color()
        make.font = LSPFont(fontSize: 12)
        make.textAlignment = .right
    }
    
    /// 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 基础设置
    override func basicStyle() {
        self.cellHeight = 100;
    }
    
    /// 创建视图
    override func setupView() {
        // 添加子视图
        self.contentView.addSubviews(views: [iconImg,titleLbl,contentLbl,timeLbl])
        // 添加约束
        iconImg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
        }
        timeLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 90, height: 20))
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-50-(90+1), height: 30))
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(iconImg.snp_right).offset(10)
        }
        contentLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-110, height: 20))
            make.left.equalTo(titleLbl)
            make.top.equalTo(titleLbl.snp_bottom).offset(10)
        }
    }
    
    /// 数据处理
    @discardableResult
    override func setModel(model: Dictionary<String, Any>) -> CGFloat {
        iconImg.image = UIImage(named: model.getString(dic: model, key: "icon"))
        timeLbl.text = model.getString(dic: model, key: "time")
        // 自适应宽度
        let timeWidth: CGFloat = LSPUtils.calculateWidthForLabel(label: timeLbl, height: 20)
        timeLbl.snp.remakeConstraints { (make) in
            make.size.equalTo(CGSize(width: timeWidth+1, height: 20))
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
        }
        titleLbl.text = model.getString(dic: model, key: "title")
        titleLbl.snp.remakeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-50-(timeWidth+1), height: 30))
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(iconImg.snp_right).offset(10)
        }
        contentLbl.text = model.getString(dic: model, key: "content")
        // 自适应高度
        var contentHeight: CGFloat = LSPUtils.calculateHeightForLabel(label: contentLbl, width: Screen_Width-110)
        if contentHeight>40{
            contentHeight=40
        }
        contentLbl.snp.remakeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-110, height: contentHeight+1))
            make.left.equalTo(titleLbl)
            make.top.equalTo(titleLbl.snp_bottom).offset(10)
        }
        self.cellHeight = 100
        self.height = self.cellHeight
        return self.cellHeight;
    }
}
