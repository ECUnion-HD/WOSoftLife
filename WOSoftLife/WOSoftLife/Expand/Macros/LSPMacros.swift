//
//  LSPMacros.swift
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

// MARK: - 屏幕宽度/高度
public let Screen_Width = UIScreen.main.bounds.width;
public let Screen_Height = UIScreen.main.bounds.height;
public let Screen_Bounds = UIScreen.main.bounds
public let Screen_Min = min(Screen_Width, Screen_Height)
public let Screen_Max = max(Screen_Width, Screen_Height)
/// 等比缩放
public func Size_Scale(a : CGFloat) -> CGFloat{
    return a * Screen_Width / 750.0
}

// MARK: - 适配相关设置
/// 底部安全距离
public let LSPBottomSafeAreaHeight: CGFloat = {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    } else {
        return 0.0
    }
}()
/// 判断是不是iPhoneX系列
public let isIPhoneXSeries: Bool = {
    var iPhoneXSeries:Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return iPhoneXSeries
    }
    if LSPBottomSafeAreaHeight > 0.0 {
        iPhoneXSeries = true
    }
    return iPhoneXSeries
}()
/// 状态栏高度
public let LSPStatusBarHeight = UIApplication.shared.statusBarFrame.height;
/// 顶部的安全距离
public let LSPTopSafeAreaHeight = CGFloat(isIPhoneXSeries ? 24 : 0)
/// 导航栏高度
public let LSPNavigationHeight = CGFloat(isIPhoneXSeries ? 88 : 64)
/// 底部tabbar高度
public let LSPTabBarHeight = CGFloat(isIPhoneXSeries ? (LSPBottomSafeAreaHeight + 49) : 49)

// MARK: - 常用字体设置
/// Normal字体
public func LSPFont(fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize)
}
///加粗字体
public func LSPBoldFont(fontSize : CGFloat) -> UIFont{
    return UIFont.boldSystemFont(ofSize: fontSize)
}

// MARK: - 常用颜色设置
/// 随机色
public func LSPRandomColor() -> UIColor {
    let red = CGFloat(arc4random()%256)/255.0
    let green = CGFloat(arc4random()%256)/255.0
    let blue = CGFloat(arc4random()%256)/255.0
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}
/// 颜色 - RGB - 不带透明度
public func LSPColor_RGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alhpa: CGFloat = 1.0) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alhpa)
}
/// 颜色 - RGB - 带透明度
public func LSPColor_RGBA(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alpha:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}
/// 颜色 - 16进制 支持0xFF55c9c4格式
public func LSPColor_Hex(h: Int) -> UIColor {
    return LSPColor_RGBA(r: CGFloat(((h)>>16) & 0xFF), CGFloat(((h)>>8) & 0xFF), CGFloat((h) & 0xFF), alpha: 1.0)
}
/// 颜色 - 16进制 支持"#55c9c4"和"55c9c4"格式
public func LSPColor_HexStr(_ hexString: String) -> UIColor {
    return hexString.toUIColor()
}

/// 主题色
public func mainColor() -> UIColor {
    return LSPColor_Hex(h: 0x1296db)
}
/// 背景色
public func mainBGColor() -> UIColor {
    return LSPColor_Hex(h: 0xf3f5f8)
}
/// 线条颜色
public func lineColor() -> UIColor {
    return LSPColor_Hex(h: 0xebf0f4)
}
/// 正文文本颜色
public func Text59Color() -> UIColor {
    return LSPColor_Hex(h: 0x596c83)
}
/// 次要文本颜色
public func TextA4Color() -> UIColor {
    return LSPColor_Hex(h: 0xa4afbc)
}

// MARK: - 单例
public let LSPKeyWindow = UIApplication.shared.keyWindow
public let LSPAppdelegate = UIApplication.shared.delegate
public let LSPUserDefaults = UserDefaults.standard
public let LSPNotiCenter:NotificationCenter = NotificationCenter.default

// MARK: - debug打印
public func LSPLog<T>(_ message : T ,file : String = #file,function : String = #function, line : Int = #line){
    #if DEBUG
    let str1 = (file as NSString).lastPathComponent
    let str2 = NSMutableString.init(string: str1)
    let range = NSRange.init(location: 0, length: str2.length)
    str2.replaceOccurrences(of: ".swift", with: "", options: NSString.CompareOptions.backwards, range: range)
    print("<\(str2)--\(function)>[\(line)]:\(message)")
    #endif
}

// MARK: - 打开APP权限设置
public func openSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
    UIApplication.shared.open(url, options: [:])
}

// MARK: 代理
@objc protocol LSPRefreshDelegate: NSObjectProtocol {
    @objc optional func pullDownRefresh()
    @objc optional func pullUpLoadMore()
}

