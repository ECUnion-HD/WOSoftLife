//
//  LSPMessage.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/8.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPMessage: Codable {
    var code: Int
    var data: LSPData
    struct LSPData: Codable {
        var stateCode: Int
        var message: String
        var returnData: LSPReturnData?
    }
    
    struct LSPReturnData: Codable {
        var rankinglist: [LSPRankingList]?
    }
    
    struct LSPRankingList: Codable {
        var title: String
        var subTitle: String
        var cover: String
        var argName: String
        var argValue: Int
        var rankingType: String
    }
}
