//
//  Global.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import Foundation
import UIKit
import MBProgressHUD

let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
let myApp = UIApplication.shared.delegate as! AppDelegate
var progressHud = MBProgressHUD()

func showLoading() {
    DispatchQueue.main.async {
        if progressHud.superview != nil {
            progressHud.hide(animated: false)
        }
        if let view = (myApp.window?.rootViewController?.view) {
            progressHud = MBProgressHUD.showAdded(to: view, animated: true)
        }
        if #available(iOS 9.0, *) {
            progressHud.bezelView.color = UIColor.white // Your backgroundcolor
            progressHud.bezelView.style = .solidColor
            /*UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.AppColor.primaryColor
             UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).tintColor = .red*/
        } else {
            
        }
        DispatchQueue.main.async {
            progressHud.show(animated: true)
        }
    }
}

func dissmissLoader() {
    DispatchQueue.main.async {
        progressHud.hide(animated: true)
    }
}

//MARK: DeviceTarget
public struct DeviceTarget {
    public static let CURRENT_DEVICE: CGFloat = UIScreen.main.bounds.height
    
    public static let IPHONE_4: CGFloat = 480
    public static let IPHONE_5: CGFloat = 568
    public static let IPHONE_6: CGFloat = 667
    public static let IPHONE_6_Plus: CGFloat = 736
    
    public static let IS_IPHONE_4 = UIScreen.main.bounds.height == IPHONE_4
    public static let IS_IPHONE_5 = UIScreen.main.bounds.height == IPHONE_5
    public static let IS_IPHONE_6 = UIScreen.main.bounds.height == IPHONE_6
    public static let IS_IPHONE_6_Plus = UIScreen.main.bounds.height == IPHONE_6_Plus
}


