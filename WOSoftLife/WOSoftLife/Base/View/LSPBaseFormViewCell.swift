//
//  LSPBaseFormViewCell.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

// 验证block
typealias LSPVerifyBlock = (_ value: String) -> String

class LSPBaseFormViewCell: UITableViewCell {
    
    /// cell高度
    var cellHeight: CGFloat = 50.0
    /// 控制器
    var controller: LSPBaseModuleVC?
    /// 值
    var cellValue: String = ""
    /// 显示视图
    var textView: UIView?
    /// 标题标签
    var lblName: UILabel?
    /// 提示
    var placeHolderStr: String = ""
    /// 键
    var key: String = ""
    /// 是否必填
    var isRequire: Bool?
    /// 长度限制
    var fieldLength: NSInteger?
    /// 规则验证block
    var verifyBlock: LSPVerifyBlock!
    
    // MARK: 初始化相关
//    init(withKey key: String) {
//        super.init()
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func midInit() {
        self.selectionStyle = .none
        self.cellHeight  = 55
        self.height = self.cellHeight
        // 默认必填
        self.isRequire = true
        self.fieldLength = 20
    }
}
