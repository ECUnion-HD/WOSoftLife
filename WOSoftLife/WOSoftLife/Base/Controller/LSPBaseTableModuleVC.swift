//
//  LSPBaseTableModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit
import MJRefresh

class LSPBaseTableModuleVC: LSPBaseModuleVC , LSPRefreshDelegate {
    
    var tableView: UITableView!
    var style: (UITableView.Style)!
    // 代理
    weak var refreshDelegate: LSPRefreshDelegate?
    // 刷新控件 - 是否需要
    var enableRefresh: Bool = false
    var enableSRefresh: Bool {
        get {
            return enableRefresh
        }
        set {
            enableRefresh = newValue
            if !enableRefresh {
                self.tableView.mj_header = nil
            }
        }
    }
    var enableLoadMore: Bool = false
    var enableSLoadMore: Bool {
        get {
            return enableLoadMore
        }
        set {
            enableLoadMore = newValue
            if !enableLoadMore {
                self.tableView.mj_footer = nil
            }
        }
    }
    
    var loading:Bool = true
    var loaded:Bool = false
    // 是否是表单
    var isForm:Bool = false
    
    // MARK: 初始化
    init() {
        super.init(nibName: nil, bundle: nil)
        self.isForm = false
    }
    
    init(isForm: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isForm = isForm
    }
    
    init(withStyle style: UITableView.Style, withIsForm isForm: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        self.isForm = isForm
    }
    
    required init?(coder: NSCoder) {
        self.isForm = false
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// 解决navigationBar.isTranslucent=false视图整体下移问题
        self.extendedLayoutIncludesOpaqueBars = true
        
        if (self.style != nil)&&self.style.rawValue>0 {
            self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - LSPBottomSafeAreaHeight), style: self.style)
        } else {
            self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - LSPBottomSafeAreaHeight))
        }
        self.tableView?.backgroundColor = mainBGColor()
        self.tableView?.separatorStyle = .none
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.refreshDelegate = self
        self.tableView?.estimatedRowHeight = 0
        self.tableView?.estimatedSectionHeaderHeight = 0
        self.tableView?.estimatedSectionFooterHeight = 0
        /// 空表格样式
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        /// 不是表单就刷新
        if !self.isForm {
            // 顶部刷新
            self.tableView.mj_header = MJRefreshNormalHeader()
            self.tableView.mj_header?.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
            // 底部刷新
            self.tableView.mj_footer = MJRefreshBackNormalFooter()
            self.tableView.mj_footer?.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        }
    }
    
    // MARK: 刷新相关设置
    /// 下拉刷新
    @objc func loadNewData() {
        if (self.refreshDelegate != nil) {
            self.refreshDelegate?.pullDownRefresh?()
        }
    }
    
    /// 上拉加载更多
    @objc func loadMoreData() {
        if (self.refreshDelegate != nil) {
            self.refreshDelegate?.pullUpLoadMore?()
        }
    }
    
    /// 开始刷新
    func beginBDRefresh() {
        self.tableView.mj_header?.beginRefreshing()
    }
    
    // 停止刷新
    func stopBDRefresh() {
        if self.tableView.mj_header?.isRefreshing ?? false {
            if self.tableView.mj_totalDataCount() == 0 {
                
            } else {
                
            }
            self.tableView.mj_header?.endRefreshing()
        } else if self.tableView.mj_footer?.isRefreshing ?? false {
            self.tableView.mj_footer?.endRefreshing()
        }
    }
}

extension LSPBaseTableModuleVC: UITableViewDelegate ,UITableViewDataSource {
    // MARK: UITableView代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = mainBGColor()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
}
