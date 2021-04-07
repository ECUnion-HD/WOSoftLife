//
//  LSPUtils.swift
//  WOSoftLife
//
//  Created by 欧盟🇪🇺委员会 on 2021/4/7.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//
//  让我们一起写虫子吧！
//  Let's write bugs together!
//

import UIKit

class LSPUtils: NSObject {
    
    // MARK: 文本计算方法
     /// 计算文字大小
     /// - Parameters:
     ///   - font: 字体
     ///   - size: 大小
     ///   - mode: 文字展示类型
     /// - Returns: 文字大小
     public func calculateSizeForText(textString text: String, systemFont font: UIFont, constrainedToSize size: CGSize, lineBreakMode mode: NSLineBreakMode) -> CGSize {
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
     public func calculateWidthForText(textString text: String, font: UIFont, size: CGSize) -> CGFloat {
        return self.calculateSizeForText(textString: text, systemFont: font, constrainedToSize: size, lineBreakMode: NSLineBreakMode.byWordWrapping).width
     }
     /// 计算文字标签宽度
     /// - Parameters:
     ///   - label: 文字标签
     ///   - height: 标签高度
     /// - Returns: 标签宽度
     public func calculateWidthForLabel(label: UILabel, height: CGFloat) -> CGFloat {
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
     public func calculateHeightForText(textString text: String, font: UIFont, size: CGSize) -> CGFloat {
        return self.calculateSizeForText(textString: text, systemFont: font, constrainedToSize: size, lineBreakMode: NSLineBreakMode.byWordWrapping).height
     }
     /// 计算文字标签高度
     /// - Parameters:
     ///   - label: 文字标签
     ///   - width: 标签宽度
     /// - Returns: 标签高度
     public func calculateHeightForLabel(label: UILabel, width: CGFloat) -> CGFloat {
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return (label.text?.boundingRect(with: CGSize(width: width, height: 1000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : label.font!], context: nil).height)!
     }
     
}
