//
//  Extension.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import Foundation
import UIKit


private var cornerRadiusValue : CGFloat = 0
private var corners : UIRectCorner = []

//MARK: UIDevice
extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        }
        return false
    }
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String {
#if os(iOS)
            switch identifier {
            case "iPhone1,1" : return "iPhone"
            case "iPhone1,2" : return "iPhone 3G"
            case "iPhone2,1" : return "iPhone 3GS"
            case "iPhone3,1" : return "iPhone 4"
            case "iPhone3,2" : return "iPhone 4 GSM Rev A"
            case "iPhone3,3" : return "iPhone 4 CDMA"
            case "iPhone4,1" : return "iPhone 4S"
            case "iPhone5,1" : return "iPhone 5 (GSM)"
            case "iPhone5,2" : return "iPhone 5 (GSM+CDMA)"
            case "iPhone5,3" : return "iPhone 5C (GSM)"
            case "iPhone5,4" : return "iPhone 5C (Global)"
            case "iPhone6,1" : return "iPhone 5S (GSM)"
            case "iPhone6,2" : return "iPhone 5S (Global)"
            case "iPhone7,1" : return "iPhone 6 Plus"
            case "iPhone7,2" : return "iPhone 6"
            case "iPhone8,1" : return "iPhone 6s"
            case "iPhone8,2" : return "iPhone 6s Plus"
            case "iPhone8,4" : return "iPhone SE (GSM)"
            case "iPhone9,1" : return "iPhone 7"
            case "iPhone9,2" : return "iPhone 7 Plus"
            case "iPhone9,3" : return "iPhone 7"
            case "iPhone9,4" : return "iPhone 7 Plus"
            case "iPhone10,1" : return "iPhone 8"
            case "iPhone10,2" : return "iPhone 8 Plus"
            case "iPhone10,3" : return "iPhone X Global"
            case "iPhone10,4" : return "iPhone 8"
            case "iPhone10,5" : return "iPhone 8 Plus"
            case "iPhone10,6" : return "iPhone X GSM"
            case "iPhone11,2" : return "iPhone XS"
            case "iPhone11,4" : return "iPhone XS Max"
            case "iPhone11,6" : return "iPhone XS Max Global"
            case "iPhone11,8" : return "iPhone XR"
            case "iPhone12,1" : return "iPhone 11"
            case "iPhone12,3" : return "iPhone 11 Pro"
            case "iPhone12,5" : return "iPhone 11 Pro Max"
            case "iPhone12,8" : return "iPhone SE 2nd Gen"
            case "iPhone13,1" : return "iPhone 12 Mini"
            case "iPhone13,2" : return "iPhone 12"
            case "iPhone13,3" : return "iPhone 12 Pro"
            case "iPhone13,4" : return "iPhone 12 Pro Max"
            case "iPhone14,2" : return "iPhone 13 Pro"
            case "iPhone14,3" : return "iPhone 13 Pro Max"
            case "iPhone14,4" : return "iPhone 13 Mini"
            case "iPhone14,5" : return "iPhone 13"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
#endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
}

//MARK: UIImage
extension UIImage {
    
    var hasImage: Bool {
        return !(cgImage == nil && ciImage == nil)
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        let megaByte = 1000.0
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > megaByte { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
                  let imageData = resizedImage.pngData() else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct AppColor {
        //HRU
        static let primaryColor = UIColor.init(named: "SpaceCadet")  ?? UIColor.clear
        static let orangeColor = UIColor.init(named: "OrangeSoda")  ?? UIColor.clear
        static let blackColor = UIColor.black
        static let titleColor = UIColor.init(named: "titleColor") ?? .black
        static let shadowColor = UIColor.lightGray //UIColor.hexStringToUIColor(hex: "1f2628")
        static let grayColor = UIColor.init(named: "GrayColor") ?? .red
        static let fontGrayColor = UIColor.init(named: "QuickSilver")  ?? UIColor.clear
        static let borderColor = UIColor.init(named: "ChineseSilver")  ?? UIColor.clear
    }
    
    static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            //            if let color = layer.shadowColor {
            return UIColor(cgColor: UIColor.AppColor.shadowColor.cgColor)
            //            }
            //            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var dashBorder: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.setDashBorder()
            } else {
                layer.borderColor = UIColor.clear.cgColor
                layer.borderWidth = 0
            }
        }
    }
    
    @objc /*@IBInspectable var shadowColor: UIColor?{
     set {
     guard let uiColor = newValue else { return }
     layer.shadowColor = uiColor.cgColor
     }
     get{
     guard let color = layer.shadowColor else { return nil }
     return UIColor(cgColor: color)
     }
     }
     
     @IBInspectable var shadowOpacity: Float{
     set {
     layer.shadowOpacity = newValue
     }
     get{
     return layer.shadowOpacity
     }
     }
     
     @IBInspectable var shadowOffset: CGSize{
     set {
     layer.shadowOffset = newValue
     }
     get{
     return layer.shadowOffset
     }
     }
     
     @IBInspectable var shadowRadius: CGFloat{
     set {
     layer.shadowRadius = newValue
     }
     get{
     return layer.shadowRadius
     }
     }*/
    
    
    /* @IBInspectable public var radius : CGFloat {
     get {
     return cornerRadiusValue
     }
     set {
     cornerRadiusValue = newValue
     }
     }
     
     @IBInspectable public var topLeft : Bool {
     get {
     return corners.contains(.topLeft)
     }
     set {
     setCorner(newValue: newValue, for: .topLeft)
     }
     }
     
     @IBInspectable public var topRight : Bool {
     get {
     return corners.contains(.topRight)
     }
     set {
     setCorner(newValue: newValue, for: .topRight)
     }
     }
     
     @IBInspectable public var bottomLeft : Bool {
     get {
     return corners.contains(.bottomLeft)
     }
     set {
     setCorner(newValue: newValue, for: .bottomLeft)
     }
     }
     
     @IBInspectable public var bottomRight : Bool {
     get {
     return corners.contains(.bottomRight)
     }
     set {
     setCorner(newValue: newValue, for: .bottomRight)
     }
     }*/
    
    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }
    
    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }
    
    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }
    
    func updateCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    //    func showBlurLoader() {
    //        let blurLoader = BlurLoader(frame: frame)
    //        self.addSubview(blurLoader)
    //    }
    //
    //    func removeBluerLoader() {
    //        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
    //            blurLoader.removeFromSuperview()
    //        }
    //    }
    
    func setBorder(width: CGFloat, color: UIColor){
        self.borderColor = color
        self.borderWidth = width
    }
    
    func setDashBorder(){
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = 1
        dashBorder.strokeColor = UIColor.AppColor.orangeColor.cgColor
        dashBorder.lineDashPattern = [8, 5] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func addShadow(shadowOffset: CGSize = CGSize(width: 0, height: 0),
                   shadowOpacity: Float = 0.25,
                   shadowRadius: CGFloat = 5) {
        layer.shadowColor = self.shadowColor?.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
    }
    
    func addShadows(shadowColor: UIColor,
                    shadowOffset: CGSize,
                    shadowOpacity: Float,
                    shadowRadius: CGFloat) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    // Set Gradient Layer
    func setUpGradientLayer(colors: [UIColor], direction: Direction = .top) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [self] in
            let gradientLayer = applyGradient(colours: colors)//linear(to: direction, colors: colors, locations: [0.0, 1.0])
            gradientLayer.frame = self.bounds
            gradientLayer.name = "Header Gradient Layer"
            gradientLayer.zPosition = -1
            self.layer.addSublayer(gradientLayer)
        }
        self.clipsToBounds = true
    }
    
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        self.layer.insertSublayer(gradient, at: 0)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2.0
        self.clipsToBounds = true
        return gradient
    }
    
    func LableWithTag(_ tag:Int) -> UILabel {
        if let lable = self.viewWithTag(tag){
            return lable as! UILabel
        }
        return  UILabel()
    }
    func ImageViewWithTag(_ tag:Int) -> UIImageView {
        if let lable = self.viewWithTag(tag){
            return lable as! UIImageView
        }
        return  UIImageView()
    }
    func ButtonWithTag(_ tag:Int) -> UIButton {
        if let lable = self.viewWithTag(tag){
            return lable as! UIButton
        }
        return  UIButton()
    }
}

public enum Direction {
    case top
    case left
    case right
    case bottom
    case degree(CGFloat)
}

public func linear(to direction: Direction, colors: [CGColor], locations: [NSNumber], filter: CIFilter? = nil) -> CAGradientLayer {
    let layer = CAGradientLayer()
    layer.startPoint = direction.startPoint
    layer.endPoint = direction.endPoint
    layer.colors = colors
    layer.locations = locations
    if let filter = filter {
        layer.backgroundFilters = [filter]
    }
    return layer
}

public extension Direction {
    var startPoint: CGPoint {
        switch self {
        case .top:
            return CGPoint(x: 0.5, y: 1.0)
        case .left:
            return CGPoint(x: 1.0, y: 0.5)
        case .right:
            return CGPoint(x: 0.0, y: 0.5)
        case .bottom:
            return CGPoint(x: 0.5, y: 0.0)
        case .degree(let degree):
            let radian = degree * .pi / 180
            return CGPoint(x: 0.5 * (cos(radian) + 1), y: 0.5 * (1 - sin(radian)))
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .top:
            return CGPoint(x: 0.5, y: 0.0)
        case .left:
            return CGPoint(x: 0.0, y: 0.5)
        case .right:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottom:
            return CGPoint(x: 0.5, y: 1.0)
        case .degree(let degree):
            let radian = degree * .pi / 180
            return CGPoint(x: 0.5 * (cos(radian + .pi) + 1), y: 0.5 * (1 + sin(radian)))
        }
    }
}
