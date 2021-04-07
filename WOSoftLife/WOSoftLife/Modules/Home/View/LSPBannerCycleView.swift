//
//  LSPBannerCycleView.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit
import ZCycleView
import Kingfisher

class LSPBannerCycleView: UICollectionReusableView {
    
    // 轮播图
    let cycleView = ZCycleView().then { (make) in
        make.placeholderImage = UIImage(named: "sc_nopic")
    }
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 170)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        cycleView.setUrlsGroup(["sc_banner0","sc_banner1","sc_banner2"], titlesGroup: ["一缕情丝，一缕温暖","快速匹配，及时推送","生活不易，呵呵一笑"])
        cycleView.delegate = self
        self.addSubviews(views: [cycleView,iconImg,titleLbl])
        /// 添加约束
        cycleView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width, height: 120))
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        iconImg.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 25, height: 25))
            make.top.equalTo(cycleView.snp_bottom).offset(12.5)
            make.left.equalToSuperview().offset(15)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-70, height: 30))
            make.centerY.equalTo(iconImg)
            make.left.equalTo(iconImg.snp_right).offset(10)
        }
    }
}

extension LSPBannerCycleView: ZCycleViewProtocol {
    // MARK: ZCycleViewProtocol
    /// 图片加载
    func cycleViewConfigureDefaultCellImageUrl(_ cycleView: ZCycleView, imageView: UIImageView, imageUrl: String?, index: Int) {
        // 本地图片
        imageView.image = UIImage(named: imageUrl!)
        // 网络图片
//        imageView.kf.setImage(with: ImageResource(downloadURL: URL(string: imageUrl!)!), placeholder: UIImage(named: "sc_nopic"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    /// 文字设置
    func cycleViewConfigureDefaultCellText(_ cycleView: ZCycleView, titleLabel: UILabel, index: Int) {
        titleLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        titleLabel.textColor = .white
        titleLabel.font = LSPFont(fontSize: 14)
    }
    /// 圆点设置
    func cycleViewConfigurePageControl(_ cycleView: ZCycleView, pageControl: ZPageControl) {
        pageControl.currentDotSize = CGSize(width: 12, height: 12)
        pageControl.pageIndicatorTintColor = mainBGColor()
        pageControl.currentPageIndicatorTintColor = mainColor()
        pageControl.alignment = .right
    }

}
