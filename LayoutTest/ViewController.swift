//
//  ViewController.swift
//  LayoutTest
//
//  Created by mlc on 1/9/2021.
//

import UIKit
import SwiftyXMLParser

class ViewController: UIViewController {
    var vd:ViewData = ViewData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        
        for v:UIView in self.view.subviews {
            if v != sender {
                v.removeFromSuperview()
            }
        }
        
        if let xml = try? XML.parse(getJiaojiaJiLuLayout()),let pvd = vd.parseByXml(element: xml.element!){
            vd = pvd
        }
        let vb = ViewDataBuilder(layoutData: vd, data: [:]) { (str, dic) in
            
        }.creatLayout(superView: self.view)
        
        view.addSubview(vb)
        vb.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
        }
     
        

    }
    
    func getDemo2() -> String{
        return """
            <Layout weight="1" width="-1" marginLeft="8" orientation="vertical" >
            
                <Layout width="-1" orientation="horizontal" valign="center">
                    <Label weight="1" value="庄福秋" maxLines="1" textColor="#060E1D" fontWeight="bold" fontSize="16"/>
                    <Label value="2020-07-01 10:47:36" maxLines="1" textColor="#999999" fontSize="13" />
                </Layout>
            
                <Layout width="-1" orientation="horizontal">
                    <Label weight="1" maxLines="1" value="0-100万元 90-100平 纯住宅" textColor="#999999" fontSize="13" />
                </Layout>
            
                <Layout width="-1" height="20" orientation="horizontal" paddingLeft="0" paddingTop="2" paddingBottom="2" paddingRight="4" valign="center">
                      <Label weight="1" maxLines="1" value="0-100万元 90-100平 纯住宅" textColor="#999999" fontSize="13" />
                </Layout>
            
            </Layout>
        """
    }
    
    func getDemo() ->String{
        return """
           <Layout orientation="vertical" width="-1" borderRadius="9"  borderWidth="1"  borderColor="#FF3333" background="#FFFAFA" padding="10 5 0 5" valign="center">
               <Label value="Y121.15" width="-1" height="0" fontSize="11" textColor="#FF5252" background="#000000" margin="5 5 5 5"/>
               <Label value="Y121.15" width="-1" height="0" fontSize="11" textColor="#FF5252" background="#000000" margin="5 5 5 5"/>
               <Label value="Y121.15" width="-1" height="0" fontSize="11" textColor="#FF5252" background="#000000" margin="5 5 5 5"/>
               <Layout orientation="vertical" width="-1" borderRadius="9"  borderWidth="1"  borderColor="#FF3333" background="#FFFAFA" padding="10 5 0 5" valign="center">
                   <Label value="Y121.15" width="-1" height="0" fontSize="11" textColor="#FF5252" background="#000000" margin="5 5 5 5"/>
                   <Label value="Y121.15" width="-1" height="0" fontSize="11" textColor="#FF5252" background="#000000" margin="5 5 5 5"/>
                   <Label value="Y121.15" width="-1" height="0" fontSize="11" textColor="#FF5252" background="#000000" margin="5 5 5 5"/>
                   
               </Layout>
           </Layout>
        """
    }
    
    ///叫价记录
    func getJiaojiaJiLuLayout() -> String{
        return """
            <Layout orientation="vertical" padding="8 24 8 24" weight="100" height="200">
                <StackLayout width="-1" height="0" background="#fff2f2"  borderRadius="5" shadowColor="#002fff" shadowWidth="5">
                    <Layout orientation="vertical" weight="-1" height="0">
                    <Layout orientation="horizontal" marginLeft="8" marginRight="8" valign="center" paddingTop="8">
                        <Label value="王猛" width="0" height="0" fontSize="14" fontWeight="bold" textColor="#333333" />
                        <Label value="2021-8-5" weight="1" height="0" fontSize="11" textColor="#ACACAC" textAlign="right"/>
                    </Layout>
                    <Line width="-1" height="1" background="#EAEAEA" marginLeft="8" marginRight="8" marginTop="8" marginBottom="13"/>
            
                        <Layout orientation="horizontal" width="-1"  marginLeft="8" marginRight="8" valign="bottom" marginBottom="6">
                            <Label value="Y2034.89万"  weight="1" width="0" height="0" fontSize="14" fontWeight="bold" textColor="#333333" />
                            <Label value="Y2034.89万" weight="1" width="0" height="0" fontSize="11" textColor="#999999"  textDecoration="lineThrough"/>
                        </Layout>
        
                        <Layout orientation="horizontal" width="-1" marginLeft="8" marginRight="8" marginBottom="14" >
                        <Layout  weight="1"   >
                            <Layout width="0" height="0" orientation="horizontal"  borderRadius="9"  borderWidth="1"  borderColor="#FF3333" background="#FFFAFA" padding="0 5 0 5" valign="center">
                                <Image value="arrow_up" width="10" height="10" padding="0 3 0 3"/>
                                <Label value="5%" width="0" height="0" fontSize="11" textColor="#FF5252"/>
                            </Layout>
                            </Layout>
                            <Layout  weight="1"   >
                            <Layout width="0" height="0" borderRadius="9"  borderWidth="1"  borderColor="#FF3333" background="#FFFAFA" padding="0 5 0 5" valign="center">
                                <Image value="arrow_up" width="10" height="10" padding="0 3 0 3"/>
                                <Label value="Y121.15" width="0" height="0" fontSize="11" textColor="#FF5252"/>
                            </Layout>
                            </Layout>
                            
                        </Layout>
                        
                    </Layout>
            
                </StackLayout>
            </Layout>
      """
    }
    
    
    //匹配客户
    func getPiPeiKeHu() -> String{
        return """
            <Layout  width="-1" orientation="vertical" background="#ffffff">
            <Layout width="-1" paddingLeft="8" paddingRight="24" paddingTop="10" paddingBottom="10" orientation="horizontal" valign="top">
            
                <Layout width="36" height="36">
                    <Image width="36" height="36" value="kehutouxiang" errorPlaceholder="images/uplink/com_kehutouxiang.png" />
                </Layout>
                <Layout weight="1" marginLeft="100" orientation="vertical" >
                    <Layout width="-1" orientation="horizontal" valign="center">
                        <Label weight="1" value="庄福秋" maxLines="1" textColor="#060E1D" fontWeight="bold" fontSize="16"/>
                        <Label value="2020-07-01 10:47:36" maxLines="1" textColor="#999999" fontSize="13" />
                    </Layout>
            
                    <Layout width="-1" orientation="horizontal">
                        <Label weight="1" maxLines="1" value="0-100万元 90-100平 纯住宅" textColor="#999999" fontSize="13" />
                    </Layout>
            
                    <Layout width="-1" height="20" orientation="horizontal" paddingLeft="0" paddingTop="2" paddingBottom="2" paddingRight="4" valign="center">
                         <Label weight="1" maxLines="1" value="0-100万元 90-100平 纯住宅" textColor="#999999" fontSize="13" />
                    </Layout>
        
                </Layout>
            </Layout>
            <Line width="-1" height="1" marginLeft="24" marginRight="24" background="#eaeaea"/>
            </Layout>
      """
    }
    
    
    ///状态记录
    func getZhuangtaiJiluLayout() ->String{
        return """
        <Layout orientation="horizontal" width="-1" padding="0 24 0 24"  background="#FFFAFA">
          <Layout orientation="vertical" width = "10" weight="0" align="center"  marginRight="16">
            <Line width="7" height="7" background="#F73343" borderRadius="3.5"/>
            <Line width="2" height="57" borderRadius="0"  background="#F73343" gradientDirection="vertical"/>
          </Layout>
          <Layout orientation="vertical"   weight="1" height="0" valign="center">
            <Layout orientation="horizontal" marginBottom="5">
                <Label value="2019-09-26" weight="1" height="0" fontSize="11" textColor="#999999"/>
                <Label value="活跃" width="0" fontSize="10" textColor="#999999" background="#FFF6EB" padding="0 5 0 5" borderRadius="3"/>
            </Layout>
            <Layout orientation="horizontal" valign="center">
                <Label value="王某某" width="0" height="0" fontSize="14" fontWeight="bold" textColor="#333333" marginRight="12"/>
                <Layout orientation="horizontal" padding="2 8 2 8" background="#F7F8FF" borderRadius="10" valign="center">
                  <Label value="暂缓" width="0" height="0" fontSize="11" fontWeight="bold" textColor="#9198BF"/>
                  <Image value="kehutouxiang" width="16" height="4" padding="0 3 0 3"/>
                  <Label value="放售" width="0" height="0" fontSize="11" fontWeight="bold" textColor="#9198BF"/>
                </Layout>
            </Layout>
         </Layout>
      </Layout>
      """
    }
    
    
}

