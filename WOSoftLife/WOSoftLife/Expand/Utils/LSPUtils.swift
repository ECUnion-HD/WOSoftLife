//
//  LSPUtils.swift
//  WOSoftLife
//
//  Created by Liu Chuanyong on 2021/4/8.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//

import UIKit
import UIKit
import AVFoundation
import UserNotifications
import Photos
import MapKit
import EventKit
import Contacts
import Speech
import MediaPlayer
import HealthKit
import CoreMotion

class LSPUtils: NSObject {

    // MARK: 文本计算方法
    /// 计算文字大小
    /// - Parameters:
    ///   - font: 字体
    ///   - size: 大小
    ///   - mode: 文字展示类型
    /// - Returns: 文字大小
    class func calculateSizeForText(textString text: String, systemFont font: UIFont, constrainedToSize size: CGSize, lineBreakMode mode: NSLineBreakMode) -> CGSize {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = mode
        paragraphStyle.alignment = .left
        var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font : font]
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        let rect = text.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return CGSize(width: ceil(rect.size.width), height: ceil(rect.size.height))
    }
    /// 计算文字宽度
    /// - Parameters:
    ///   - font: 字体
    ///   - size: 大小
    /// - Returns: 文字宽度
    class func calculateWidthForText(textString text: String, font: UIFont, size: CGSize) -> CGFloat {
        return self.calculateSizeForText(textString: text, systemFont: font, constrainedToSize: size, lineBreakMode: NSLineBreakMode.byWordWrapping).width
    }
    /// 计算文字标签宽度
    /// - Parameters:
    ///   - label: 文字标签
    ///   - height: 标签高度
    /// - Returns: 标签宽度
    class func calculateWidthForLabel(label: UILabel, height: CGFloat) -> CGFloat {
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        let autoWidth: CGFloat! = label.text?.boundingRect(with: CGSize(width: 1000, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : label.font!], context: nil).width
        return autoWidth
     }
     /// 计算文字高度
     /// - Parameters:
     ///   - font: 字体
     ///   - size: 大小
     /// - Returns: 文字高度
    class func calculateHeightForText(textString text: String, font: UIFont, size: CGSize) -> CGFloat {
        return self.calculateSizeForText(textString: text, systemFont: font, constrainedToSize: size, lineBreakMode: NSLineBreakMode.byWordWrapping).height
    }
    /// 计算文字标签高度
    /// - Parameters:
    ///   - label: 文字标签
    ///   - width: 标签宽度
    /// - Returns: 标签高度
    class func calculateHeightForLabel(label: UILabel, width: CGFloat) -> CGFloat {
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return (label.text?.boundingRect(with: CGSize(width: width, height: 1000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : label.font!], context: nil).height)!
    }
    
    /// 字典转JSON
    class func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    /// JSON转字典
    class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    /// base64加密
    class func encodingBase64(String str:String) -> String{
        let data = str.data(using: String.Encoding.utf8)
        return (data?.base64EncodedString(options: .lineLength64Characters))!
    }
    
    /// 颜色生成图片
    class func createImageFrom(Color color:UIColor) -> UIImage{
        let rect = CGRect(x:0, y:0, width:1, height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    enum LSPPermissionType: Int {
        /// 相机
        case camera = 0
        /// 相册
        case photoLibrary = 1
        /// 推送
        case notification = 2
        /// 麦克风
        case microphone = 3
        /// 定位
        case location = 4
    }
    /// 是否允许权限
    class func isAllowed(_ permission: LSPPermissionType) -> Bool {
        let manager = getManagerForPermission(permission)
        return manager.isAuthorized
    }
    /// 是否拒绝权限
    class func isDenied(_ permission: LSPPermissionType) -> Bool {
        let manager = getManagerForPermission(permission)
        return manager.isDenied
    }
    /// 请求权限
    class func request(_ permission: LSPPermissionType, with сompletionCallback: ((LSPAuthorizationStatus)->())?) {
        let manager = getManagerForPermission(permission)
        manager.request { (status) in
            DispatchQueue.main.async {
                сompletionCallback?(status)
            }
        }
    }
}

extension LSPUtils {
    private class func getManagerForPermission(_ permission: LSPPermissionType) -> LSPPermissionInterface {
        switch permission {
        case .camera:
            return LSPCameraPermission()
        case .photoLibrary:
            return LSPPhotoLibraryPermission()
        case .notification:
            return LSPNotificationPermission()
        case .microphone:
            return LSPMicrophonePermission()
        case .location:
            return LSPLocationPermission()
        }
    }
}
