//
//  LSPNewsListCell.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//

import UIKit

class LSPNewsListCell: LSPBaseTableViewCell {
    
    /// 初始化
    // 状态
    let stateBtn =  UIButton().then({ (make) in
        make.setTitle("已完成", for: .normal)
        make.setTitleColor(.white, for: .normal)
        make.setBackgroundImage(UIImage(named: "bg_finish"), for: .normal)
        make.adjustsImageWhenHighlighted = false
        make.titleLabel?.font = LSPFont(fontSize: 14)
    })
    // 姓名
    let nameLbl = UILabel().then({ (make) in
        make.text = "姓名：欧盟🇪🇺委员会"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // 线条
    let lineView = UIView().then { (make) in
        make.backgroundColor = lineColor()
    }
    // 内容
    let contentLbl = UILabel().then({ (make) in
        make.text = "毕业院校：麻省理工学院（MIT）"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // 详细
    let detailLbl = UILabel().then({ (make) in
        make.text = "主攻专业：电子信息工程"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // 时间
    let timeLbl = UILabel().then({ (make) in
        make.text = "毕业时间：2020.08.20"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })

    /// 初始化
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 基础设置
    override func basicStyle() {
        self.cellHeight = 155
        self.backgroundColor = mainBGColor()
    }
    
    /// 界面布局
    override func setupView() {
        /// 背景
        let bgView = UIView().then { (make) in
            make.backgroundColor = .white
            make.layer.cornerRadius = 5;
        }
        self.contentView.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-30, height: 145))
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        /// 添加子视图
        bgView.addSubviews(views: [stateBtn,nameLbl,contentLbl,lineView,detailLbl,timeLbl])
        /// 添加约束
        stateBtn.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 65, height: 20))
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
        })
        // 姓名
        nameLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60-70, height: 40))
            make.centerY.equalTo(self.stateBtn)
            make.left.equalToSuperview().offset(15)
        })
        lineView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 0.5));
            make.top.equalTo(self.nameLbl.snp_bottom);
            make.left.equalTo(self.nameLbl);
        }
        // 学校
        contentLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 30))
            make.top.equalTo(lineView.snp_bottom).offset(5)
            make.left.equalTo(self.nameLbl)
        })
        // 专业
        detailLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 30))
            make.top.equalTo(self.contentLbl.snp_bottom)
            make.left.equalTo(self.nameLbl)
        })
        // 时间
        timeLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 30))
            make.top.equalTo(self.detailLbl.snp_bottom)
            make.left.equalTo(self.nameLbl)
        })
    }
    
    /// 数据处理
    @discardableResult
    override func setModel(model: Dictionary<String, Any>) -> CGFloat {
        nameLbl.text = "姓名：\(model.getString(dic: model , key: "name"))"
        contentLbl.text = "毕业院校：\(model.getString(dic: model , key: "school"))"
        detailLbl.text = "主攻专业：\(model.getString(dic: model , key: "major"))"
        timeLbl.text = "毕业时间：\(model.getString(dic: model , key: "time"))"
        stateBtn.setTitle(model.getString(dic: model, key: "stateName"), for: .normal)
        let iconArr = ["bg_end","bg_wait","bg_wait","bg_in","bg_finish","bg_not"]
        let state = model.getInt(dic: model, key: "state")
        let imgStr: String = iconArr[state]
        stateBtn.setBackgroundImage(UIImage(named: imgStr), for: .normal)
        self.cellHeight = 155
        self.height = self.cellHeight
        return self.cellHeight;
    }
}
