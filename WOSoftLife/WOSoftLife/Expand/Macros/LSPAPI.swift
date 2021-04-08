//
//  LSPAPI.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/8.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//

import Foundation
import Moya

enum LSPAPI {
    //排行榜
    case rankList
    
    ///其他接口...
    case other1(p1: String, p2: Int, p3: String, p4: String)
    
    case other2

}

// 补全【MoyaConfig 3：配置TargetType协议可以一次性处理的参数】中没有处理的参数
extension LSPAPI: TargetType {
    //1. 每个接口的相对路径
    //请求时的绝对路径是   baseURL + path
    var path: String {
        switch self {
        case .rankList:
            return "rank/list"
        case let .other1(p1, p2, _, _):
            return "rank/list?pid=\(p1)&page=\(p2)"
        case .other2:
            return ""
        }
    }

    //2. 每个接口要使用的请求方式
    var method: Moya.Method {
        switch self {
        case .rankList:
            return .post
        case .other1:
            return .post
        case .other2:
            return .get
        }
    }

    //3. Task是一个枚举值，根据后台需要的数据，选择不同的http task。
    var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .rankList:
            return .requestPlain
        case let .other1(_, _, p3, p4):
            params["p3"] = p3
            params["p4"] = p4
        default:
            //不需要传参数的接口走这里
            return .requestPlain
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
}
