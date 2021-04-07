//
//  LSPBaseFormModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPBaseFormModuleVC: LSPBaseTableModuleVC {
    
    var cells:NSMutableArray!
    
    // MARK: 初始化
    override init() {
        super.init(isForm: true)
        self.tableView.backgroundColor = mainBGColor()
        self.cells = NSMutableArray()
    }
    
    init(withStyle style: UITableView.Style) {
        super.init(withStyle: style, withIsForm: true)
        self.tableView.backgroundColor = mainBGColor()
        self.cells = NSMutableArray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UITableView代理
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.cells.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows: NSArray = self.cells[section] as! NSArray
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rows: NSArray = self.cells[indexPath.section] as! NSArray
        return rows[indexPath.row] as! LSPBaseFormViewCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView().then { (make) in
            make.backgroundColor = mainBGColor()
        }
        if section == 0 {
            sectionView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 0.01)
        } else {
            sectionView.frame = CGRect(x: 0, y: 0, width: Screen_Width, height: 10)
        }
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rows: NSArray = self.cells[indexPath.section] as! NSArray
        let cell: LSPBaseFormViewCell = rows[indexPath.row] as! LSPBaseFormViewCell
        return cell.cellHeight
    }
}
