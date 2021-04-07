//
//  LSPHomeModuleVC.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPHomeModuleVC: LSPBaseModuleVC {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /// 创建视图
    override func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (Screen_Width-60)/4, height:  (Screen_Width-60)/4)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 15)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LSPHomeModuleCell.self, forCellWithReuseIdentifier: "LSPHomeModuleCell")
        collectionView.register(LSPBannerCycleView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LSPBannerCycleView")
        collectionView.register(LSPSectionHeadView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "LSPSectionHeadView")
        collectionView.backgroundColor = mainBGColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(Screen_Height-LSPBottomSafeAreaHeight-LSPTabBarHeight)
            make.top.equalToSuperview()
        }
    }
}

extension LSPHomeModuleVC: UICollectionViewDelegate ,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionView代理
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LSPHomeModuleCell", for: indexPath) as! LSPHomeModuleCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: Screen_Width, height: 170)
        } else {
            return CGSize(width: Screen_Width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            var headView = LSPBannerCycleView()
            if kind == UICollectionView.elementKindSectionHeader {
                headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LSPBannerCycleView", for: indexPath) as!  LSPBannerCycleView
                return headView
            } else {
                return UICollectionReusableView.init()
            }
        } else {
            var headView = LSPSectionHeadView()
            if kind == UICollectionView.elementKindSectionHeader {
                headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LSPSectionHeadView", for: indexPath) as!  LSPSectionHeadView
                return headView
            } else {
                return UICollectionReusableView.init()
            }
        }
    }
}
