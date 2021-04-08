//
//  LSPBaseModel.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/8.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

enum HttpCode : Int {
    case success = 1 //请求成功的状态吗
    case needLogin = -1  // 返回需要登录的错误码
}

struct LSPBaseModel: Decodable {
    var code: Int
    var data: Content
    struct Content: Decodable {
        var message: String
    }
}


extension LSPBaseModel {
    var generalCode: Int {
        return code
    }

    var generalMessage: String {
        return data.message
    }
}

