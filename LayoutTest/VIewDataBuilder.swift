//
//  VIewDataBuilder.swift
//  LayoutTest
//
//  Created by mlc on 3/9/2021.
//

import Foundation
import UIKit
import SnapKit


typealias ClickCallback = (_ key:String,_ data:[String:Any]) -> Void

class ViewDataBuilder: NSObject {
    var mLayoutData:ViewData!
    var mData:Dictionary<String,Any>!
    var mClickCallback:ClickCallback?
    
    
    init(layoutData:ViewData,data:Dictionary<String,Any>,clickCallback:ClickCallback?) {
        mLayoutData = layoutData
        mData = data;
        mClickCallback = clickCallback
    }
    
    func creatLayout(superView:UIView) -> UIView{
        let v =  _parseLayout(viewData: mLayoutData, superView: superView)
        v.snp.makeConstraints { (make) in

        }

        return v
    }
    
    
    func _parseLayout(viewData:ViewData,superView:UIView) ->UIView{
        let stackView:UIStackView  = UIStackView()
        if viewData.isVertical() {
            stackView.axis = .vertical
            if viewData.getVAlign() == .center {
                stackView.alignment = .center
            }
            if viewData.getVAlign() == .top {
                stackView.alignment = .top
            }
            if viewData.getVAlign() == .bottom {
                stackView.alignment = .bottom
            }
        }else{
            stackView.axis = .horizontal
            
            if viewData.getAlign() == .center {
                stackView.alignment = .center
            }
            if viewData.getAlign() == .left {
                stackView.alignment = .leading
            }
            if viewData.getAlign() == .right {
                stackView.alignment = .trailing
            }
        }

        stackView.snp.makeConstraints { (make) in
            //
        }
        //superView.addSubview(stackView);
        if let views = viewData.inDic[attr_views] as? [ViewData]{
            views.forEach{(elm) in
                var tmpView:UIView;
                if elm.isStackLayout(){
                    tmpView = _parseStackLayout(viewData: elm, superView: stackView)
                }else if (elm.isLayout()) {
                    tmpView = _parseLayout(viewData: elm, superView: stackView)
                } else {
                    tmpView  = _parseView(viewData: elm, superView: stackView)
                }
                stackView.addArrangedSubview(tmpView);
                addConstraints(viewData: elm, view: tmpView, superView: stackView)
            }
        }
        return _surroundContainer(viewData: viewData, view: stackView, superView: superView);
    }
    
    ///添加约束
    public func addConstraints(viewData:ViewData,view:UIView,superView:UIView){

        let width:Double = viewData.inDic[attr_width] as? Double ?? 0
        let height:Double = viewData.inDic[attr_height] as? Double ?? 0
        
        if width < 0 {
            view.snp.makeConstraints({ (make) in
                make.width.equalTo(superView)
            })
        }else if (width == 0){
            //
            view.snp.makeConstraints({ (make) in
                //make.width.equalTo(width)
            })
        }else{
            view.snp.makeConstraints({ (make) in
                make.width.equalTo(width)
            })
        }
        
        if height < 0 {
            view.snp.makeConstraints({ (make) in
                make.width.equalToSuperview()
            })
        }
        else if (height == 0){
            //
            view.snp.makeConstraints({ (make) in
                //make.width.equalTo(width)
            })
        }
        else{
            view.snp.makeConstraints({ (make) in
                make.height.equalTo(height)
            })
        }
        
        if viewData.getAttribute(key: "isInStack") as? Bool ?? false  == true{

        }else{
            

        }
    }
    
    func _parseStackLayout(viewData:ViewData,superView: UIView) -> UIView{
        
//        var children:[UIView] = []
//        if let views = viewData.inDic[attr_views] as? [ViewData]{
//            views.forEach{(elm) in
//                if elm.isStackLayout(){
//                    children.append(_parseStackLayout(viewData: elm, superView: superView))
//                }else if elm.isLayout() {
//                    children.append(_parseLayout(viewData: elm, superView: superView))
//                } else {
//                    children.append(_parseView(viewData: elm, superView: superView))
//                }
//            }
//        }
//
//        let view = UIView()
//
//        for elm in children {
//            view.addSubview(elm);
//        }
        
        let stackView:UIStackView  = UIStackView()
        if viewData.isVertical() {
            stackView.axis = .vertical
            if viewData.getVAlign() == .center {
                stackView.alignment = .center
            }
            if viewData.getVAlign() == .top {
                stackView.alignment = .top
            }
            if viewData.getVAlign() == .bottom {
                stackView.alignment = .bottom
            }
        }else{
            stackView.axis = .horizontal
            
            if viewData.getAlign() == .center {
                stackView.alignment = .center
            }
            if viewData.getAlign() == .left {
                stackView.alignment = .leading
            }
            if viewData.getAlign() == .right {
                stackView.alignment = .trailing
            }
        }

        stackView.snp.makeConstraints { (make) in
            //
        }
        //superView.addSubview(stackView);
        if let views = viewData.inDic[attr_views] as? [ViewData]{
            views.forEach{(elm) in
                var tmpView:UIView;
                if elm.isStackLayout(){
                    tmpView = _parseStackLayout(viewData: elm, superView: stackView)
                }else if (elm.isLayout()) {
                    tmpView = _parseLayout(viewData: elm, superView: stackView)
                } else {
                    tmpView  = _parseView(viewData: elm, superView: stackView)
                }
                stackView.addArrangedSubview(tmpView);
                addConstraints(viewData: elm, view: tmpView, superView: stackView)
            }
        }
        
        let sView = UIView()
        sView.addSubview(stackView)

        return _surroundContainer(viewData: viewData, view: sView, superView: superView)
    }
    
    
    func _parseView(viewData:ViewData,superView:UIView) -> UIView{
        let needUseAlign = true;
        var iView:UIView!
        guard let type = viewData.inDic[attr_type] as? String else { return UIView() }
        switch type.lowercased(){
        case VIEWTYPE_Image:
            iView = _parseViewForImage(viewData: viewData)!
            break
        case VIEWTYPE_Line:
            iView = _parseViewForLine(viewData: viewData)
            break
        case VIEWTYPE_Image:
            iView = _parseViewForImage(viewData: viewData)!
            break
        case VIEWTYPE_Tags:
            iView = _parseViewForTags(viewData: viewData)
            break
        case VIEWTYPE_Label:
            iView = _parseViewForText(viewData: viewData)
            break
        default:
            iView = _parseViewForText(viewData: viewData)
        }
        iView = _surroundContainer(viewData: viewData,view: iView, superView: superView, needUseAlign:needUseAlign)
        return iView
    }
    
    func _parseViewForImage(viewData:ViewData) ->UIView? {
        var  value:String? = viewData.inDic[attr_value] as? String
        let placeholder:String? = viewData.inDic[attr_placeholder] as? String
        let error:String? = viewData.inDic[attr_error_placeholder] as? String
        let canClick:String? = viewData.inDic[attr_clickable] as? String
        
        value = _analysisValue(value)
        if value == nil || value?.count == 0{
            if error == nil || error == "" {
                return nil
            }else{
                return UIImageView(image: UIImage(named: error ?? ""))
            }
        }
        
        let isLocalImage = !(value?.hasPrefix("http") ?? false)
        if isLocalImage {
            let imgColor:String? = viewData.inDic[attr_textColor] as? String;
            var color:UIColor?
            let localImg = UIImageView(image: UIImage(named: value ?? ""))
            if let imgColor = imgColor {
                color = imgColor.hexColor
            }
            if let canClick = canClick,canClick != "" {
                localImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabAction)))
            }
            return localImg
        }
        if let placeholder = placeholder , !placeholder.isEmpty {
            return UIImageView(image: UIImage(named: placeholder))
        }
        
        if let error = error ,!error.isEmpty {
            return UIImageView(image: UIImage(named: error))
        }
        let imgView = UIImageView()
        imgView.setNetImg(imgUrl: value,placeholder:placeholder,errorStr: error)
        return imgView
        
        //return UIView()
    }
    
    @objc func tabAction(gesture:UIGestureRecognizer){
        if let mBack =  mClickCallback{
            mBack("key",mData)
        }
    }
    
    func _parseViewForLine(viewData:ViewData)  ->UIView {
        
        return UIView()
    }
    
    func _parseViewForTags(viewData:ViewData)  ->UIView {
        return UIView()
    }
    
    func _parseViewForText(viewData:ViewData)  ->UIView {
        var value:String? = viewData.inDic[attr_value] as? String
        var colorString:String? = viewData.inDic[attr_textColor] as? String
        let textDecoration:String? = viewData.inDic[attr_textDecoration] as? String
        let textSize:Int? = viewData.inDic[attr_fontSize] as? Int
        let isBold:Bool = viewData.inDic[attr_fontWeight] as? String == FONTWEIGHT_bold
        let lines:Int? = viewData.inDic[attr_maxLines] as? Int
        let align =  viewData.inDic[attr_align] as? String
        
        value = _analysisValue(value)
        colorString = _analysisValue(colorString)
        var textColor:UIColor?
        if let colorString = colorString {
            textColor = colorString.hexColor
        }
        let label = UILabel()
        label.text = value
        label.textAlignment = _getTextAlign(align: align)
        label.attributedText = _getTextDecoration(decoration: textDecoration, label: label)
        if #available(iOS 13.0, *) {
            label.textColor = textColor ?? UIColor.label
        } else {
            // Fallback on earlier versions
            label.textColor = textColor ?? UIColor.darkGray
        }
        label.font = UIFont.systemFont(ofSize: CGFloat(textSize ?? 14), weight: isBold ? .bold : .medium)
        label.numberOfLines = lines ?? 0 > 0 ? lines ?? 0 : 0
        //
        return label
    }
    
    
    
    func _getTextDecoration(decoration:String?,label:UILabel) ->NSAttributedString{
        switch decoration {
        case "underline":
            return label.setAttribute(key: .underlineStyle);
        case "overline":
            return label.setAttribute(key: .underlineStyle);
        case "lineThrough":
            return label.setAttribute(key: .underlineStyle);
        default:
            return NSAttributedString(string: label.text!);
        }
    }
    
    func _getTextAlign(align:String?) -> NSTextAlignment{
        if let align = align {
            switch (align) {
            case ALIGN_left:
                return .left;
            case ALIGN_right:
                return .right;
            case ALIGN_center:
                return .center;
            default:
                return .natural;
            }
        }
        return .left
    }
    
    func _surroundContainer(viewData:ViewData,view:UIView,superView:UIView,needUseAlign:Bool = false) -> UIView{
        
        var left:Double? = viewData.inDic[attr_paddingLeft] as? Double
        var top:Double? = viewData.inDic[attr_paddingTop] as? Double
        var right:Double? = viewData.inDic[attr_paddingRight] as? Double
        var bottom:Double? = viewData.inDic[attr_paddingBottom] as? Double
        
        if let padding:String = viewData.inDic[_attr_padding] as? String{
            let ps = padding.split(separator: " ")
            top = Double(ps[0])
            right = Double(ps[1])
            bottom = Double(ps[2])
            left = Double(ps[3])
        }
        
        
        let borderRadius:Double? = viewData.inDic[attr_borderRadius] as? Double
        let borderRadius_topLeft:Double? = viewData.inDic[attr_borderRadius_topLeft] as? Double
        let borderRadius_topRight:Double? = viewData.inDic[attr_borderRadius_topRight] as? Double
        let borderRadius_bottomLeft:Double? = viewData.inDic[attr_borderRadius_bottomLeft] as? Double
        let borderRadius_bottomRight:Double? = viewData.inDic[attr_borderRadius_bottomRight] as? Double
        let borderWidth:Double? = viewData.inDic[attr_borderWidth] as? Double
        let shadowWidth:Double? = viewData.inDic[attr_shadowWidth] as? Double
        
        let width:Double = viewData.inDic[attr_width] as? Double ?? 0
        let height:Double = viewData.inDic[attr_height] as? Double ?? 0
        
        var background:String? = viewData.inDic[attr_background] as? String
        var borderColor:String? = viewData.inDic[attr_borderColor] as? String
        var shadowColor:String? = viewData.inDic[attr_shadowColor] as? String
        var gradientColor:String? = viewData.inDic[attr_gradientColor] as? String
        let _:String = viewData.inDic[attr_gradientDirection] as? String ?? HORIZONTAL
        //颜色动态取值
        background = _analysisValue(background);
        borderColor = _analysisValue(borderColor);
        shadowColor = _analysisValue(shadowColor);
        gradientColor = _analysisValue(gradientColor);
        
        var gradientColors:[UIColor] = []
        if let gradientColor = gradientColor,gradientColor.split(separator:"-").count >= 2{
            gradientColor.split(separator: "-").forEach { (elm) in
                gradientColors.append(String(elm).hexColor)
            }
        }
        
        var containerView = UIView()
        containerView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            //内距box1边距分别为10、20、30、40
            make.edges.equalTo(containerView).inset(UIEdgeInsets(top: CGFloat.init(top ?? 0),
                                                                 left:  CGFloat.init(left ?? 0),
                                                                 bottom:  CGFloat.init(bottom ?? 0),
                                                                 right:  CGFloat.init(right ?? 0)))
        })
        
        
        
        left   = viewData.inDic[attr_marginLeft] as? Double
        top   = viewData.inDic[attr_marginTop] as? Double
        right  = viewData.inDic[attr_marginRight] as? Double
        bottom = viewData.inDic[attr_marginBottom] as? Double
        
        
        let marginView = UIView()
        marginView.addSubview(containerView)
        containerView.snp.makeConstraints({ (make) in
            //内距box1边距分别为10、20、30、40
            make.edges.equalTo(marginView).inset(UIEdgeInsets(top: CGFloat.init(top ?? 0),
                                                                 left:  CGFloat.init(left ?? 0),
                                                                 bottom:  CGFloat.init(bottom ?? 0),
                                                                 right:  CGFloat.init(right ?? 0)))
        })
        
        containerView = marginView

//        //margin
//        if let margin:String = viewData.inDic[_attr_margin] as? String{
//            let ps = margin.split(separator: " ")
//            top = Double(ps[0])
//            right = (Double(ps[1]) ?? 0)
//            bottom = (Double(ps[2]) ?? 0)
//            left = Double(ps[3])
//
//            view.snp.makeConstraints({ (make) in
//                if let left = viewData.inDic[attr_marginLeft] as? Double {
//                    make.left.equalTo(superView).offset(left)
//                }
//                if let right = viewData.inDic[attr_marginRight] as? Double  {
//                    make.right.equalTo(superView).offset(-right)
//                }
//                if let top = viewData.inDic[attr_marginTop] as? Double  {
//                    make.top.equalTo(superView).offset(top)
//                }
//                if let bottom = viewData.inDic[attr_marginBottom] as? Double  {
//                    make.bottom.equalTo(superView).offset(-bottom)
//                }
//            })
//        }else{
//
//            view.snp.makeConstraints({ (make) in
//                if let left = left {
//                    make.left.equalTo(superView).offset(left)
//                }
//                if let right = right {
//                    make.right.equalTo(superView).offset(-right)
//                }
//                if let top = top {
//                    make.top.equalTo(superView).offset(top)
//                }
//                if let bottom = bottom {
//                    make.bottom.equalTo(superView).offset(-bottom)
//                }
//            })
//        }
    
        //superView.addSubview(containerView)

        
        if let borderWidth = borderWidth {
            containerView.layer.borderWidth = CGFloat(borderWidth)
        }
        if let borderColor = borderColor {
            containerView.layer.borderColor = borderColor.hexColor.cgColor
        }
  
        if let shadowColor = shadowColor {
            containerView.setShadow(color: shadowColor.hexColor)
        }
        
        if let shadowWidth = shadowWidth {
            containerView.setShadow(color: shadowColor?.hexColor ?? UIColor.clear,offset: CGSize(width: shadowWidth,height: shadowWidth))
        }
        
        if let background = background {
            containerView.backgroundColor = background.hexColor
        }
        
        if gradientColors.count > 2 {
            containerView.setGradient(colors: gradientColors)
        }

        if let borderRadius = borderRadius{
            containerView.layer.cornerRadius = CGFloat(borderRadius)
        }else{
            if let borderRadius_topLeft = borderRadius_topLeft {
                containerView.setSingleCorners(radius: borderRadius_topLeft, corners: .topLeft, cornerRadii: CGSize(width: width, height: height))
            }
            if let borderRadius_topRight = borderRadius_topRight {
                containerView.setSingleCorners(radius: borderRadius_topRight, corners: .topRight, cornerRadii: CGSize(width: width, height: height))
            }
            if let borderRadius_bottomLeft = borderRadius_bottomLeft {
                containerView.setSingleCorners(radius: borderRadius_bottomLeft, corners: .bottomLeft, cornerRadii: CGSize(width: width, height: height))
            }
            if let borderRadius_bottomRight = borderRadius_bottomRight {
                containerView.setSingleCorners(radius: borderRadius_bottomRight, corners: .bottomRight, cornerRadii: CGSize(width: width, height: height))
            }
        }
        
        //containerView = _surroundExpanded(viewData: viewData, view: containerView, superView: superView)

        return containerView
    }
    
    func _surroundClickAndVisibility(viewData:ViewData,view:UIView?) -> UIView{
        return UIView();
    }
    
    func _surroundExpanded(viewData:ViewData,view:UIView,superView:UIView) -> UIView{
        if let weight:Int = viewData.inDic[attr_weight] as? Int,weight > 0 {
            view.snp.makeConstraints({ (make) in
                make.width.equalTo(superView).multipliedBy(weight)
            })
        }
        return superView
    }
    
    let braces_left = "{{"
    let braces_right = "}}"
    
    func _analysisValue(_ str:String?) -> String?{

        if (str == nil || str?.count ?? 0 < 4) {
            return str;
        }
        if let value = str,
           let index_left = braces_left.atIndex(of: value),
           let index_right = braces_right.atIndex(of: value),
           index_left>=0, index_right>0,
           index_left<index_right
        {
            var tmpStr = value.subString(start: index_left+2, end: index_right)
            var tmpValue = value.subString(start: 0, end: index_left)
                + (mData[tmpStr] as? String ?? "")
                + value.subStringToEnd(from: index_right+2)
            
            var indexLeft = braces_left.atIndex(of: tmpValue) ?? -1
            var indexRight = index_right
            if indexLeft >= 0 {
                while indexLeft >= 0 {
                    indexRight = braces_right.atIndex(of: tmpValue) ?? -1
                    if indexRight > 0 {
                        tmpStr = tmpValue.subString(start: indexLeft+2, end: indexRight).trim()
                        tmpValue = tmpValue.subString(start: 0, end: indexLeft)
                            + (mData[tmpStr] as? String ?? "")
                            + tmpValue.subStringToEnd(from: index_right+2)
                        indexLeft = braces_left.atIndex(of: tmpValue) ?? -1
                    }else{
                        indexLeft = -1
                    }
                }
            }
            return tmpValue
        }
        return str;
    }
    
    func _handleLocalImagePath(path:String?) -> String{
        if (path == nil || path?.count == 0) {
            return "";
        }
        return path ?? ""
    }
    
}
