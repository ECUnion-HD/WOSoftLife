//
//  LSPNewsListIndexVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPNewsListIndexVC: LSPBaseTableModuleVC {
    
    var dataArr: NSMutableArray = NSMutableArray()
    var page: NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.beginBDRefresh()
    }
    
    func pullDownRefresh() {
        self.page = 1
        self.queryListData()
    }

    func pullUpLoadMore() {
        self.queryListData()
    }
    
    // MARK: 数据处理
    func queryListData() {
        self.stopBDRefresh()
        if self.page==1 {
            self.dataArr = NSMutableArray()
        }
        let cellModel = [["name" : "欧盟🇪🇺委员会", "school" : "麻省理工学院（MIT）", "major" : "电子信息工程", "time" : "2020.08.20", "stateName" : "已完成", "state" : 3],["name" : "隔壁🌟老王", "school" : "哈佛大学（HU）", "major" : "生命科学", "time" : "2020.08.20", "stateName" : "待审核", "state" : 1],["name" : "隔壁🌟老李", "school" : "耶鲁大学（YU）", "major" : "历史", "time" : "2020.08.20", "stateName" : "未完成", "state" : 4],["name" : "隔壁🌟老张", "school" : "密歇根大学（TUM）", "major" : "医学", "time" : "2020.08.20", "stateName" : "审核中", "state" : 2],["name" : "隔壁🌟老扬", "school" : "斯坦福大学（SU）", "major" : "能源与环境科学", "time" : "2020.08.20", "stateName" : "未提交", "state" : 0],["name" : "隔壁🌟老江", "school" : "牛津大学（UFO）", "major" : "人文学", "time" : "2020.08.20", "stateName" : "审核中", "state" : 2],["name" : "隔壁🌟老赵", "school" : "剑桥大学（UC）", "major" : "建筑学", "time" : "2020.08.20", "stateName" : "审核中", "state" : 2],["name" : "隔壁🌟老孙", "school" : "帝国理工学院（IC）", "major" : "自然科学", "time" : "2020.08.20", "stateName" : "待审核", "state" : 1]]
        if cellModel.count>0 {
            self.page += 1
            self.dataArr.addObjects(from: cellModel as [Any])
        }
        self.tableView.reloadData()
    }
    
    // MARK: UITableView代理
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "LSPNewsListCell"
        let cell = LSPNewsListCell(style: .default, reuseIdentifier: identifier)
        cell.controller = self
        if self.dataArr.count>0 {
            let model: Dictionary = self.dataArr[indexPath.section] as! Dictionary<String, Any>
            cell.setModel(model: model)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 {
            return 10.0
        }
        return 0.01
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = mainBGColor()
        if section==0 {
            sectionView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 10)
        }
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = LSPNewsListCell()
        if self.dataArr.count>0 {
            let model: Dictionary = self.dataArr[indexPath.section] as! Dictionary<String, Any>
            cell.setModel(model: model)
        }
        return cell.cellHeight
    }

}
