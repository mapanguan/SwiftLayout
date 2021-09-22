//
//  VIewData.swift
//  LayoutTest
//
//  Created by mlc on 1/9/2021.
//

import Foundation
import UIKit
import SwiftyXMLParser

enum ALIGIN :String {
    case left =  "left"
    case center = "center"
    case right = "right"
    
    static func getAligin(aligin:Any?) -> ALIGIN{
        return ALIGIN(rawValue: aligin as? String ?? "") ?? ALIGIN.left
    }
}

//（top、center、bottom）
enum V_ALIGIN :String {
    case top =  "top"
    case center = "center"
    case bottom = "bottom"
    
    static func getVAligin(aligin:Any?) -> V_ALIGIN{
        return V_ALIGIN(rawValue: aligin as? String ?? "") ?? V_ALIGIN.center
    }
}

extension ViewData:XMLParserDelegate{
    
    // 遇到一个开始标签时调用
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //当elementName是 "User"时，表示开始解析一个新用户了
        switch elementName {
        case "LayoutData":
            viewData = ViewData()
            break
        case "StackLayoutData":
            viewData = ViewData()
            break
        default:
            viewData = ViewData()
            break
        }
    }
    
    // 遇到字符串时调用
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        //接下来每遇到一个字符，将该字符追加到相应的 property 中
        switch currentElement {
        case "LayoutData":
            viewData = ViewData()
            break
        case "StackLayoutData":
            viewData = ViewData()
            break
        default:
            viewData = ViewData()
            break
        }
        
    }
    
    // 遇到结束标签时调用
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        viewDatas.append(viewData);
    }
}


class ViewData: NSObject{
    
    //保存最终解析的结果
    var viewDatas:[ViewData] = []
    //当前元素名
    var currentElement = ""
    //当前用户
    var viewData:ViewData!
    
    
    var parser = XMLParser(){
        didSet{
            parser.delegate = self
        }
    }
    
    func getAlign() -> ALIGIN{
        return ALIGIN.getAligin(aligin: inDic[attr_align])
    }
    func getVAlign() -> V_ALIGIN{
        return V_ALIGIN.getVAligin(aligin: inDic[attr_valign])
    }
    
    //    var type = "";
    //    var id = "";
    //    var background = "";
    //    var align = "";
    //    var valign = "";
    //    var visibility = "";
    //    var value = "";
    //    var textAlign = "";
    //    var textColor = "";
    //    var textDecoration = "";
    //    var clickable = "";
    //    var placeholder = "";
    //    var error_placeholder = "";
    //
    //    var width = 0;
    //    var height = 0;
    //    var weight = 0;
    //
    //    var maxLines = 0;
    //    var fontSize = 0;
    //    var fontWeight = 0;
    //
    //    var padding = 0;
    //    var paddingLeft = 0;
    //    var paddingTop = 0;
    //    var paddingRight = 0;
    //    var paddingBottom = 0;
    //
    //    var margin = 0;
    //    var marginLeft = 0;
    //    var marginTop = 0;
    //    var marginRight = 0;
    //    var marginBottom = 0;
    //
    //    var borderRadius = 0;
    //    var borderRadius_topLeft = 0;
    //    var borderRadius_topRight = 0;
    //    var borderRadius_bottomLeft = 0;
    //    var borderRadius_bottomRight = 0;
    //    var borderWidth = 0;
    //
    //    var borderColor = "";
    //    var shadowWidth = 0;
    //    var shadowColor = "";
    //    var gradientColor = "";
    //    var gradientDirection = "";
    
    var inDic:[String:Any] = [:];
    
    func getAttribute(key:String) -> Any{
        return inDic[key] ?? ""
    }
    
    func isLayout() ->Bool{
        return false
    }
    
    func isStackLayout() -> Bool{
        return false
    }
    
    func isHorizontal() -> Bool{
        return inDic[attr_orientation] as? String == HORIZONTAL;
    }
    
    func isVertical() -> Bool{
        return inDic[attr_orientation] as? String == VERTICAL;
    }
    
    
    func setAttribute(key:String,value:Any) -> ViewData{
        if key == attr_width
            || key == attr_height
            || key == attr_weight
            || key == attr_maxLines
            || key == attr_fontSize
            || key == attr_fontWeight
            || key == attr_paddingTop
            || key == attr_paddingLeft
            || key == attr_paddingBottom
            || key == attr_paddingRight
            || key == attr_marginTop
            || key == attr_marginRight
            || key == attr_marginBottom
            || key == attr_marginLeft
            || key == attr_borderRadius
            || key == attr_borderRadius_topLeft
            || key == attr_borderRadius_topRight
            || key == attr_borderRadius_bottomLeft
            || key == attr_borderRadius_bottomRight
            || key == attr_borderWidth
            || key == attr_shadowWidth
        {
            inDic[key] = Double.init(value as? String ?? "0.0") ?? 0.0;
        }else{
            inDic[key] = value;
        }
        
        return self;
    }
    
    func parseByXml(element:XML.Element) -> ViewData?{
        var viewData:ViewData?
        guard let name = element.name == "XML.Parser.AbstructedDocumentRoot" ? element.childElements.first?.name  : element.name else { return viewData }
        switch name.lowercased(){
        case VIEWTYPE_Layout:
            viewData = LayoutData()
            viewData?.inDic[attr_type] = VIEWTYPE_Layout
        case VIEWTYPE_StackLayout:
            viewData = StackLayoutData()
            viewData?.inDic[attr_type] = VIEWTYPE_StackLayout
        default:
            viewData = ViewData()
            viewData?.inDic[attr_type] = name.lowercased()
        }
        
        for (key,value) in (element.name == "XML.Parser.AbstructedDocumentRoot" ? element.childElements.first! : element).attributes {
            if key == attr_width
                || key == attr_height
                || key == attr_weight
                || key == attr_maxLines
                || key == attr_fontSize
                || key == attr_fontWeight
                || key == attr_paddingTop
                || key == attr_paddingLeft
                || key == attr_paddingBottom
                || key == attr_paddingRight
                || key == attr_marginTop
                || key == attr_marginRight
                || key == attr_marginBottom
                || key == attr_marginLeft
                || key == attr_borderRadius
                || key == attr_borderRadius_topLeft
                || key == attr_borderRadius_topRight
                || key == attr_borderRadius_bottomLeft
                || key == attr_borderRadius_bottomRight
                || key == attr_borderWidth
                || key == attr_shadowWidth
            {
                viewData?.inDic[key] = Double.init(value)
            }else{
                viewData?.inDic[key] = value
            }
        }
        
        
        var datas = [ViewData?]()
        if viewData?.isLayout() ?? false || viewData?.isStackLayout() ?? false {
            (element.name == "XML.Parser.AbstructedDocumentRoot"
                ? element.childElements.first!.childElements
                : element.childElements).forEach { (elm) in
                    datas.append(parseByXml(element: elm))
                }
        }
        
        
        if datas.count > 0 {
            viewData?.inDic[attr_views] = datas
        }
        return viewData
    }
}

class LayoutData: ViewData {
    let VERTICAL = "vertical";
    let HORIZONTAL = "horizontal";
    // Layout的方向（horizontal 横向，vertical 竖向）
    let attr_orientation = "orientation";
    
    override func getAlign() -> ALIGIN{
        return ALIGIN.getAligin(aligin: inDic[attr_align] )
    }
    override func getVAlign() -> V_ALIGIN{
        return V_ALIGIN.getVAligin(aligin: inDic[attr_valign])
    }
    
    override init() {
        super.init()
        inDic[attr_orientation] = HORIZONTAL;
        inDic[attr_type] = VIEWTYPE_Layout;
    }
    
    func setOrientation(orientation:String) -> LayoutData{
        inDic[attr_orientation] = orientation
        return self;
    }
    
    func addView(view:ViewData) -> LayoutData {
        var views:Array? = getAttribute(key: attr_views) as? Array<ViewData>;
        if views == nil {
            inDic[attr_views] = [];
        }
        views?.append(view)
        return self;
    }
    
    func getViews() -> Array<ViewData>?{
        return getAttribute(key: attr_views) as? Array<ViewData>
    }
    
    override func isLayout() -> Bool{
        return true;
    }
    
    override func isStackLayout() -> Bool {
        return false;
    }
    
}

class StackLayoutData: LayoutData {
    
    override func isStackLayout() -> Bool {
        true;
    }
    
    override func getAlign() -> ALIGIN{
        return ALIGIN.getAligin(aligin: inDic[attr_align])
    }
    
    override func getVAlign() -> V_ALIGIN{
        return V_ALIGIN.getVAligin(aligin: inDic[attr_valign])
    }
    
    override init() {
        super.init()
        inDic[attr_type] = VIEWTYPE_StackLayout;
    }
}





