//
//  Keys.swift
//  LayoutTest
//
//  Created by mlc on 3/9/2021.
//

import Foundation
import UIKit

let app:UIApplicationDelegate = UIApplication.shared.delegate!

let VIEWTYPE_Label = "label";
let VIEWTYPE_Layout = "layout";
let VIEWTYPE_StackLayout = "stacklayout";
let VIEWTYPE_Image = "image";
let VIEWTYPE_Line = "line";
let VIEWTYPE_Tags = "tags";

let ALIGN_left = "left";
let ALIGN_center = "center";
let ALIGN_right = "right";
let VALIGN_top = "top";
let VALIGN_center = "center";
let VALIGN_bottom = "bottom";
let VISIBILITY_visible = "visible";
let VISIBILITY_invisible = "invisible";
let VISIBILITY_hidden = "hidden";
let VISIBILITY_gone = "gone";
let FONTWEIGHT_bold = "bold";

let  VERTICAL = "vertical";
let  HORIZONTAL = "horizontal";

let  attr_orientation = "orientation";
let attr_views = "views";

// 组件类型
let attr_type = "type";
// 组件id
let attr_id = "id";
// width 宽度（0 自适应宽度，负数 尽可能占满, 正数 固定宽度）
let attr_width = "width";
// height 高度（0 自适应高度，负数 尽可能占满，正数 固定高度）
let attr_height = "height";
// 占满剩余空间的份数比（A weight=1, B weight=2, 剩余空间为300，A占用100，B占用200）
let attr_weight = "weight";

// padding:10 5 15 20 上内边距是 10 右内边距是 5 下内边距是 15 左内边距是 20
let _attr_padding = "padding";
// 左边填充 顶边填充 右边填充 底部填充
let attr_paddingLeft = "paddingLeft";
let attr_paddingTop = "paddingTop";
let attr_paddingRight = "paddingRight";
let attr_paddingBottom = "paddingBottom";

// margin:10 5 15 20 上外边距是 10 右外边距是 5 下外边距是 15 左外边距是 20
let _attr_margin = "margin";
// 左边距 顶边距 右边距 底边距
let attr_marginLeft = "marginLeft";
let attr_marginTop = "marginTop";
let attr_marginRight = "marginRight";
let attr_marginBottom = "marginBottom";

// 背景（目前只支持颜色代码）
let attr_background = "background";
// 横向对齐方式
let attr_align = "align";
// 竖向对齐方式
let attr_valign = "valign";
// 显示状态（默认显示）
//TODO:解析中未具体实现..
let attr_visibility = "visibility";
// 组件值，从数据Model中取值，就用这种取值方式{{FieldName}}
let attr_value = "value";
// 文字横向对齐方式
let attr_textAlign = "textAlign";
// 文字颜色
let attr_textColor = "textColor";
// 字体大小
let attr_fontSize = "fontSize";
//字体修饰  none overline underline  lineThrough
let attr_textDecoration = "textDecoration";
// 字体粗细
let attr_fontWeight = "fontWeight";
// 文字占用行数（高度定位不准，故加此字段）
let attr_maxLines = "maxLines";
// 是否可点击
let attr_clickable = "clickable";
// 占位
let attr_placeholder = "placeholder";
let attr_error_placeholder = "errorPlaceholder";
//圆角
let attr_borderRadius = "borderRadius";
//单独设置圆角(如果设置了borderRadius，则分别设置无效)
let attr_borderRadius_topLeft = "borderRadius_topLeft";
let attr_borderRadius_topRight = "borderRadius_topRight";
let attr_borderRadius_bottomLeft = "borderRadius_bottomLeft";
let attr_borderRadius_bottomRight =
    "borderRadius_bottomRight";

//边框
let attr_borderWidth = "borderWidth";
//边框颜色
let attr_borderColor = "borderColor";
//阴影宽度
let attr_shadowWidth = "shadowWidth";
//阴影颜色
let attr_shadowColor = "shadowColor";
//渐变色 开始和结束颜色用 - 隔开
let attr_gradientColor = "gradientColor";
//渐变方向 默认 LayoutData.HORIZONTAL
let attr_gradientDirection = "gradientDirection";
