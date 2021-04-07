//
//  LSPBaseTableViewCell.swift
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

class LSPBaseTableViewCell: UITableViewCell {
    
    /// cell高度
    var cellHeight: CGFloat!
    /// 控制器
    var controller: LSPBaseModuleVC?
    
    /// 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.basicStyle()
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

@objc extension LSPBaseTableViewCell {

    /// 基础设置
    func basicStyle() {
        self.cellHeight  = 55
        self.height = self.cellHeight
    }
    
    /// 创建视图
    func setupView() {
    }
    
    /// 数据处理
    func setModel(model: Dictionary<String, Any>) -> CGFloat {
        return 55;
    }
}
