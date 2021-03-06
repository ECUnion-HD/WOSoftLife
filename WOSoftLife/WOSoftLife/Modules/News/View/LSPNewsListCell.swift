//
//  LSPNewsListCell.swift
//  WOSoftLife
//
//  Created by æ¬§çðªðºå§åä¼ on 2021/4/7.
//  Copyright Â© 2021 å®å¾½çåè¥å¸è½¯äººçä¿¡æ¯ææ¯è¡ä»½æéå¬å¸. All rights reserved.
//

import UIKit

class LSPNewsListCell: LSPBaseTableViewCell {
    
    /// åå§å
    // ç¶æ
    let stateBtn =  UIButton().then({ (make) in
        make.setTitle("å·²å®æ", for: .normal)
        make.setTitleColor(.white, for: .normal)
        make.setBackgroundImage(UIImage(named: "bg_finish"), for: .normal)
        make.adjustsImageWhenHighlighted = false
        make.titleLabel?.font = LSPFont(fontSize: 14)
    })
    // å§å
    let nameLbl = UILabel().then({ (make) in
        make.text = "å§åï¼æ¬§çðªðºå§åä¼"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // çº¿æ¡
    let lineView = UIView().then { (make) in
        make.backgroundColor = lineColor()
    }
    // åå®¹
    let contentLbl = UILabel().then({ (make) in
        make.text = "æ¯ä¸é¢æ ¡ï¼éº»ççå·¥å­¦é¢ï¼MITï¼"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // è¯¦ç»
    let detailLbl = UILabel().then({ (make) in
        make.text = "ä¸»æ»ä¸ä¸ï¼çµå­ä¿¡æ¯å·¥ç¨"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })
    // æ¶é´
    let timeLbl = UILabel().then({ (make) in
        make.text = "æ¯ä¸æ¶é´ï¼2020.08.20"
        make.textColor = Text59Color()
        make.font = LSPFont(fontSize: 15)
    })

    /// åå§å
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// åºç¡è®¾ç½®
    override func basicStyle() {
        self.cellHeight = 155
        self.backgroundColor = mainBGColor()
    }
    
    /// çé¢å¸å±
    override func setupView() {
        /// èæ¯
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
        /// æ·»å å­è§å¾
        bgView.addSubviews(views: [stateBtn,nameLbl,contentLbl,lineView,detailLbl,timeLbl])
        /// æ·»å çº¦æ
        stateBtn.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: 65, height: 20))
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
        })
        // å§å
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
        // å­¦æ ¡
        contentLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 30))
            make.top.equalTo(lineView.snp_bottom).offset(5)
            make.left.equalTo(self.nameLbl)
        })
        // ä¸ä¸
        detailLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 30))
            make.top.equalTo(self.contentLbl.snp_bottom)
            make.left.equalTo(self.nameLbl)
        })
        // æ¶é´
        timeLbl.snp.makeConstraints({ (make) in
            make.size.equalTo(CGSize(width: Screen_Width-60, height: 30))
            make.top.equalTo(self.detailLbl.snp_bottom)
            make.left.equalTo(self.nameLbl)
        })
    }
    
    /// æ°æ®å¤ç
    @discardableResult
    override func setModel(model: Dictionary<String, Any>) -> CGFloat {
        nameLbl.text = "å§åï¼\(model.getString(dic: model , key: "name"))"
        contentLbl.text = "æ¯ä¸é¢æ ¡ï¼\(model.getString(dic: model , key: "school"))"
        detailLbl.text = "ä¸»æ»ä¸ä¸ï¼\(model.getString(dic: model , key: "major"))"
        timeLbl.text = "æ¯ä¸æ¶é´ï¼\(model.getString(dic: model , key: "time"))"
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
