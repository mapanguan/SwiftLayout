//
//  Extentions.swift
//  LayoutTest
//
//  Created by mlc on 6/9/2021.
//

import Foundation
import UIKit


//https://www.jianshu.com/p/79b986af536e
extension String{
    /// 将十六进制颜色转伟UIColor
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        if #available(iOS 13, *) {
            guard let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) else { return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }
            
            let a, r, g, b: Int32
            switch hex.count {
            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
            default:    (a, r, g, b) = (255, 0, 0, 0)
            }
            
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
            
        } else {
            var int = UInt32()
            Scanner(string: hex).scanHexInt32(&int)
            let a, r, g, b: UInt32
            switch hex.count {
            case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
            case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
            case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
            default:    (a, r, g, b) = (255, 0, 0, 0)
            }
            
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
        }
    }
    
    ///url中有中文
    //stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    //stringByAddingPercentEncodingWithAllowedCharacters
    func chineseInUrl() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    ///去除String中空格
    public func trim() -> String {
        return self.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /// 字符串截取
    /// e.g let aaa = "abcdefghijklmnopqrstuvwxyz"  -> "cdef"
    /// - Parameters:
    ///   - start: 开始位置 3
    ///   - end: 结束位置 6
    /// - Returns: 截取后的字符串 "cdef"
    public func subString(start: Int,end: Int) -> String {
        if !(end < count) || start > end { return "取值范围错误" }
        var tempStr: String = ""
        for i in start...end {
            let temp: String = self[self.index(self.startIndex, offsetBy: i - 1)].description
            tempStr += temp
        }
        return tempStr
    }
    
    ///查询字符串所在字符串的位置
    public func atIndex(of originStr:String) -> Int?{
        if let range: Range = originStr.range(of: self){
            return  originStr.distance(from: originStr.startIndex, to: range.lowerBound)
        }
        return nil;
    }
    
    
    
    //MARK:-截取字符串从index到结束
    func subStringToEnd(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index)  else {
            return self
        }
        return String(self[start_index..<endIndex])
    }
    //MARK:-切割字符串(区间范围 前闭后开)
    func sliceString(_ range:CountableRange<Int>)->String{
        
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
        else {
            return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    //MARK:-切割字符串(区间范围 前闭后闭)
    func sliceString(_ range:CountableClosedRange<Int>)->String{
        
        guard
            let start_Index = validStartIndex(original: range.lowerBound),
            let end_Index   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
        else {
            return ""
        }
        if(endIndex.encodedOffset <= end_Index.encodedOffset){
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
        
    }
    //MARK:-校验字符串位置 是否合理，并返回String.Index
    private func validIndex(original: Int) -> String.Index {
        
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    //MARK:-校验是否是合法的起始位置
    private func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else { return nil }
        return validIndex(original:original)
    }
    //MARK:-校验是否是合法的结束位置
    private func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else { return nil }
        return validIndex(original:original)
    }
    
    
}

extension String {
    /// 字符串长度
    public var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    public var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    public var intValue: Int32 {
        return (self as NSString).intValue
    }
    public var floatValue: Float {
        return (self as NSString).floatValue
    }
    public var integerValue: Int {
        return (self as NSString).integerValue
    }
    public var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    public var boolValue: Bool {
        return (self as NSString).boolValue
    }
}

///MARK --
extension UITextField{
    func setPlaceHolderTextColor(color:UIColor,fontSize:CGFloat){
        if #available(iOS 13.0, *) {
            let arrStr = NSMutableAttributedString(string: self.placeholder ?? "",
                                                   attributes: [.foregroundColor: color,
                                                                .font: fontSize])
            self.attributedPlaceholder = arrStr
        } else {
            self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
            self.setValue(fontSize, forKeyPath:"_placeholderLabel.font")
        }
    }
    
}

extension UIImageView{
    
    func setNetImg(imgUrl:String?,placeholder:String? = nil,errorStr:String? = nil){
        
        return self.sd_setImage(with: URL(string: imgUrl ?? ""),
                                placeholderImage: UIImage(named: placeholder ?? ""),
                                options: .highPriority) { (img, error, type, url) in
            if (error != nil){
                if errorStr?.count != 0 {
                    self.image = UIImage(named: errorStr!);
                }else{
                    self.image = UIImage(named: placeholder ?? "");
                }
                
            }
        }
        
    }
    
}



extension UILabel {
    func setAttribute(key:NSAttributedString.Key) -> NSMutableAttributedString{
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(key,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            return attributedString
        }
        return NSMutableAttributedString(string: "")
    }
}

extension UIView{
    
    func setSingleCorners(radius:Double,corners:UIRectCorner,cornerRadii:CGSize){
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds,
                                              byRoundingCorners: corners,
                                              cornerRadii: cornerRadii)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = self.bounds;
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer;
    }
    
    
    /// 设置阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - offset: 阴影偏移量
    ///   - opacity: 阴影透明度
    ///   - radius: 阴影半径
    func setShadow(color: UIColor, offset:CGSize = CGSize.zero, opacity:Float = 0.8, radius:CGFloat = 5) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    ///渐变色
    func setGradient(colors:[UIColor],locations:[NSNumber] = [0.5,1.0]){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        //颜色的分界点
        gradientLayer.locations = locations
        //开始
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        //结束,主要是控制渐变方向
        gradientLayer.endPoint  = CGPoint.init(x: 1.0, y: 0.5)
        //多大区域
        gradientLayer.frame = self.bounds
        //最后作为背景
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
