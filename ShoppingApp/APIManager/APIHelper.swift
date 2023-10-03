//
//  APIHelper.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import Foundation
import SwiftyJSON
import Alamofire

final class APIHelper {
    
    //MARK: Faqs Api
    static func categoriesApi(success: @escaping(_ success: Bool, _ response: APIResponse) -> Void) {
        APIManager.shared.getRequest(method: .get, url: APIEndPoint.categories.rawValue) { response in
            if response.success == true {
                success(true, response)
            } else {
                success(false, response)
            }
        }
    }
    
    //MARK: Faqs Api
    static func categoriesProductApi(category: String, success: @escaping(_ success: Bool, _ response: APIResponse) -> Void) {
        APIManager.shared.getRequest(method: .get, url: APIEndPoint.getProductsofCategory.rawValue + "/" + category) { response in
            if response.success == true {
                success(true, response)
            } else {
                success(false, response)
            }
        }
    }
    
}
