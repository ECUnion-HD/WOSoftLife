//
//  LSPExtension.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import Foundation
import UIKit
import CommonCrypto
import CoreGraphics

public protocol Then {}

//MARK: UIView扩展
extension UIView {
    
    // 视图横坐标
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
    }
    // 视图纵坐标
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    // 视图中心点 - 横坐标
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var newCenter: CGPoint = self.center
            newCenter.x = newValue
            self.center = newCenter
        }
    }
    // 视图中心点 - 纵坐标
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            var newCenter: CGPoint = self.center
            newCenter.y = newValue
            self.center = newCenter
        }
    }
    // 视图Rect
    public var centerRect: CGRect {
        return CGRect(x: self.bounds.midX, y: self.bounds.midY, width: 0, height: 0)
    }
    // 视图左上角 - 横坐标
    public var left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
    }
    // 视图左上角 - 纵坐标
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
    }
    // 视图右下角 - 横坐标
    public var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.origin.x = newValue - newFrame.size.width
            self.frame = newFrame
        }
    }
    // 视图右下角 - 纵坐标
    public var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.origin.y = newValue - newFrame.size.height
            self.frame = newFrame
        }
    }
    // 视图宽度
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
    }
    // 视图高度
    public var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
    }
    // 视图坐标
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.origin = newValue
            self.frame = newFrame
        }
    }
    // 视图大小
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var newFrame: CGRect = self.frame
            newFrame.size = newValue
            self.frame = newFrame
        }
    }
    
    // 获取视图所在的控制器(UIViewController)
    public func getCurrentViewController() -> UIViewController?{
        var next: UIView? = self
        repeat{
            if let responder = next?.next{
                if responder is UIViewController{
                    return responder as? UIViewController
                }
            }
            next = next?.superview
        } while next != nil
        
        return nil
    }
    
    // 删除所有子对象
    public func removeAllSubviews() {
        while self.subviews.count>0 {
            let child: UIView? = self.subviews.last
            child?.removeFromSuperview()
        }
    }
    
    // 添加所有子对象
    public func addSubviews(views: [UIView]) {
        for v in views {
            self.addSubview(v)
        }
    }
}

//MARK: 初始化扩展
extension Then where Self: Any {
    
    /// 初始化后使用闭包设置属性
    ///     let frame = CGRect().with {
    ///       $0.origin.x = 10
    ///       $0.size.width = 100
    ///     }
    public func with(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    
    /// 用闭包执行某些操作
    ///     UserDefaults.standard.do {
    ///       $0.set("devxoul", forKey: "username")
    ///       $0.set("devxoul@gmail.com", forKey: "email")
    ///       $0.synchronize()
    ///     }
    public func `do`(_ block: (Self) -> Void) {
        block(self)
    }
}

extension Then where Self: AnyObject {
    
    /// 初始化后使用闭包设置属性
    ///     let label = UILabel().then {
    ///       $0.textAlignment = .Center
    ///       $0.textColor = UIColor.blackColor()
    ///       $0.text = "Hello, World!"
    ///     }
    public func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}

//MARK: Dictionary扩展
extension Dictionary {
    
    /// 获取字符串类型
    public func getString(dic:Dictionary<String,Any>!,key:String) -> String {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return ""
        } else {
            return obj as! String
        }
    }
    public func getString(dic:NSDictionary!,key:String) -> String {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return ""
        } else {
            return obj as! String
        }
    }
    
    /// 获取整型
    public func getInt(dic:Dictionary<String,Any>!,key:String) -> Int {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return 0
        } else {
            return obj as! Int
        }
    }
    public func getInt(dic:NSDictionary,key:String) -> Int {
        
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return 0
        } else {
            return obj as! Int
        }
        
    }
    
    /// 获取字典类型
    public func getDictionary(dic:Dictionary<String,Any>!,key:String) -> Dictionary<String,Any>? {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return nil
        }
        return obj as? Dictionary<String, Any>
    }
    public func getDictionary(dic:NSDictionary!,key:String) -> NSDictionary? {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return nil
        }
        return obj as? NSDictionary
    }
    
    /// 获取数组类型
    public func getArray(dic:Dictionary<String,Any>!,key:String) -> Array<Any>? {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return nil
        }
        return obj as? Array<Any>
    }
    public func getArray(dic:NSDictionary!,key:String) -> NSArray? {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return nil
        }
        return obj as? NSArray
    }
    
    /// 获取Double类型
    public func getDouble(dic:Dictionary<String,Any>!,key:String) -> Double {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return 0
        }
        return obj as! Double
    }
    public func getDouble(dic:NSDictionary,key:String) -> Double {
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return 0
        }
        return obj as! Double
    }
    
    /// 获取UIImage类型
    public func getImage(dic:Dictionary<String,Any>!,key:String) -> UIImage? {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return nil
        }
        return obj as? UIImage
    }
    public func getImage(dic:NSDictionary!,key:String) -> UIImage? {
        assert(dic != nil,"字典不能为空");
        let obj = dic[key];
        if obj is NSNull || obj == nil {
            return nil
        }
        return obj as? UIImage
    }
    
}

//MARK: String扩展
extension String {
    
    /// String使用下标截取字符串
    /// 例: "示例字符串"[0..<2] 结果是 "示例"
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// MD5加密
    public func getMD5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
        return String(hash)
    }
    
    /// 时间转换星期
    static func getWeekDayFormDate(_ time: Int) -> String {
        let weekday: NSArray = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"] as NSArray
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let calendar = Calendar(identifier: .republicOfChina)
        let components = calendar.component(.weekday, from: date)
        let weekStr = weekday.object(at: components-1)
        return weekStr as! String
    }
    
    /// 金额单位转换
    static func calculatePriceUnit(_ price: Double) -> NSString{
        let array = ["元","万元","亿元","万亿元"]
        var tempPrice = 0.0
        for i in 0..<array.count{
            if 0 < price && price < pow(10000, Double(i + 1)) {
                tempPrice = i > 0 ? price / pow(10000, Double(i)) : price
                var str = NSString(format: "%.0f", tempPrice)
                str = "\(str) \(array[i])" as NSString
                return str
            }
        }
        return "错误"
    }
    
    /// 将字节(byte单位转换)
    static func transformSize(_ size: Double) -> String {
        var newSize: Double = 0
        // 小于1024byte
        if 0 < size && size < 1024 {
            return "\(size)B"
        }
        // 1B - 1M
        else if size < 1024 * 1024 {
            newSize = size / 1024.0
            let str = String(format: "%.1f", newSize)
            return str+"KB"
        }
        // 1M - 1G
        else if size < 1024 * 1024 * 1024 {
            newSize = size / (1024.0 * 1024.0)
            let str = String(format: "%.1f", newSize)
            return str+"M"
        }
        return "模型错误"
    }
    
    /// 对象方法 (获取文件大小)
    func getFileSize() -> UInt64  {
        var size: UInt64 = 0
        let fileManager = FileManager.default
        var isDir: ObjCBool = false
        let isExists = fileManager.fileExists(atPath: self, isDirectory: &isDir)
        // 判断文件存在
        if isExists {
            // 是否为文件夹
            if isDir.boolValue {
                // 迭代器 存放文件夹下的所有文件名
                let enumerator = fileManager.enumerator(atPath: self)
                for subPath in enumerator! {
                    // 获得全路径
                    let fullPath = self.appending("/\(subPath)")
                    do {
                        let attr = try fileManager.attributesOfItem(atPath: fullPath)
                        size += attr[FileAttributeKey.size] as! UInt64
                    } catch  {
                        print("error :\(error)")
                    }
                }
            } else {    // 单文件
                do {
                    let attr = try fileManager.attributesOfItem(atPath: self)
                    size += attr[FileAttributeKey.size] as! UInt64
                    
                } catch  {
                    print("error :\(error)")
                }
            }
        }
        return size
    }

}
