//
//  Constant.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import Foundation


enum APIBaseUrlPoint: String {
    case localHostBaseURL = "https://dummyjson.com/"
}

enum APIEndPoint: String {
    case products = "products"
    case categories = "products/categories"
    case getProductsofCategory = "products/category"
}
