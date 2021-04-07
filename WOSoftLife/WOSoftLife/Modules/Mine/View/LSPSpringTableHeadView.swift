//
//  LSPSpringTableHeadView.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//  

import UIKit

class LSPSpringTableHeadView: UIView ,UIScrollViewDelegate {
    
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 视图高度
    var scImageViewHeight: CGFloat = 0.0
    var imageHeight: CGFloat? {
        didSet {
            scImageViewHeight = imageHeight!
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: imageHeight!)
        }
    }
    var imageString: String? {
        didSet {
            imageView.image = UIImage(named: imageString!)
        }
    }
    
    /// 懒加载 - 图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        self.addSubview(sloganView)
        self.addSubview(nameLbl)
        return imageView
    }()
    
    lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.text = "欧阳孔蒙"
        label.textAlignment = .center
        label.frame = CGRect(x: 60, y: imageHeight! - 55, width: Screen_Width - 120, height: 20)
        label.textColor = mainColor()
        label.font = LSPBoldFont(fontSize: 20)
        return label
    }()
    
    lazy var sloganView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sc_head"))
        imageView.frame = CGRect(x: (Screen_Width-70)/2, y: imageHeight! - 135, width: 70, height: 70)
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// 滑动代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let imageWidth = self.frame.size.width
        let imageOffsetY = scrollView.contentOffset.y
        // 上移
        if imageOffsetY<0 {
            var frame = CGRect()
            frame.origin.y = imageOffsetY
            frame.origin.x = imageOffsetY/2.0
            frame.size.width = imageWidth - imageOffsetY
            frame.size.height = scImageViewHeight - imageOffsetY
            imageView.frame = frame
        }
    }
    
}

extension UITableView {
    /// 添加头部视图
    func lsp_addSpringHeadView(view: LSPSpringTableHeadView) -> Void {
        DispatchQueue.main.async {
            let emptyHeadView = UIView(frame: view.frame)
            self.tableHeaderView = emptyHeadView
            self.showsVerticalScrollIndicator = false
            self.addSubview(view)
        }
    }
}
