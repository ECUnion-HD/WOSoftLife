//
//  LSPMessageModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPMessageModuleVC: LSPBaseTableModuleVC {
    
    var dataArr: NSMutableArray = NSMutableArray()
    var page: NSInteger!
    var model: LSPMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.separatorStyle = .singleLine
        self.beginBDRefresh()
        loadDataByMoya()
    }

    func pullDownRefresh() {
        self.page = 1
        queryListData()
    }

    func pullUpLoadMore() {
        queryListData()
    }
    
    // MARK: Moya请求
    func loadDataByMoya() {
        LSPNetWork.loadData(target: LSPAPI.rankList, model: LSPMessage.self, success: { model in
            self.model = model
//            self.tableView.reloadData()
            
        }, failure: nil)

    }
    
    // MARK: 数据处理
    func queryListData() {
        self.stopBDRefresh()
        if self.page==1 {
            self.dataArr = NSMutableArray()
        }
        let cellModel = [["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"],["icon" : "sc_head", "title" : "欧盟🇪🇺委员会通知", "content" : "特大喜讯！特大喜讯！特大喜讯！走过路过不要错过，全场只要两元。", "time" : "2020.08.20"]]
        if cellModel.count>0 {
            self.page += 1
            self.dataArr.addObjects(from: cellModel as [Any])
        }
        self.tableView.reloadData()
    }
    
    // MARK: UITableView代理
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "LSPMessageListCell"
        let cell = LSPMessageListCell(style: .default, reuseIdentifier: identifier)
        cell.controller = self
        if self.dataArr.count>0 {
            let model: Dictionary = self.dataArr[indexPath.row] as! Dictionary<String, Any>
            cell.setModel(model: model)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
