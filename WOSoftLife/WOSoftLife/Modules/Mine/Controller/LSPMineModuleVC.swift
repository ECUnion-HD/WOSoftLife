//
//  LSPMineModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPMineModuleVC: LSPBaseTableModuleVC {
    
    var dataArr: NSMutableArray = NSMutableArray()

    lazy var springHeadView: LSPSpringTableHeadView = {
        let headView = LSPSpringTableHeadView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 170))
        headView.imageHeight = 170
        headView.imageString = "mine_head"
        return headView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataArr = NSMutableArray()
        self.tableView?.separatorStyle = .singleLine
        tableView.lsp_addSpringHeadView(view: springHeadView)
        self.queryListData()
    }
    
    // MARK: 数据处理
    func queryListData() {
        
        let cellModel0 = [["icon" : "mine_safe", "title" : "安全中心", "detail" : ""],["icon" : "mine_module", "title" : "功能模块", "detail" : ""]]
        let cellModel1 = [["icon" : "mine_dynamic", "title" : "我的动态", "detail" : ""],["icon" : "mine_active", "title" : "活动中心", "detail" : ""]]
        let cellModel2 = [["icon" : "mine_balance", "title" : "我的消费", "detail" : ""],["icon" : "mine_money", "title" : "账户余额", "detail" : "¥ 0.01"]]
        let cellModel3 = [["icon" : "mine_share", "title" : "推荐分享", "detail" : ""],["icon" : "mine_feedback", "title" : "意见反馈", "detail" : ""]]
        let cellModel4 = [["icon" : "mine_set", "title" : "我的设置", "detail" : ""]]
        self.dataArr = [cellModel0,cellModel1,cellModel2,cellModel3,cellModel4]
        self.tableView.reloadData()
    }
    
    // MARK: UITableView代理
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows: NSArray = self.dataArr[section] as! NSArray
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "LSPIconLeftListCell"
        let cell = LSPIconLeftListCell(style: .default, reuseIdentifier: identifier)
        cell.controller = self
        if self.dataArr.count>0 {
            let rows: NSArray = self.dataArr[indexPath.section] as! NSArray
            let model: Dictionary<String, Any> = rows[indexPath.row] as! Dictionary<String, Any>
            cell.setModel(model: model)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = mainBGColor()
        sectionView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 10)
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = LSPIconLeftListCell()
        if self.dataArr.count>0 {
            let rows: NSArray = self.dataArr[indexPath.section] as! NSArray
            let model: Dictionary<String, Any> = rows[indexPath.row] as! Dictionary<String, Any>
            cell.setModel(model: model)
        }
        return cell.cellHeight
    }

    // MARK: ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        springHeadView.scrollViewDidScroll(scrollView)
    }
}
