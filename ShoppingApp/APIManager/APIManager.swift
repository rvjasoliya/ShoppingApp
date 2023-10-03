//
//  APIManager.swift
//  ShoppingApp
//
//  Created by iMac on 09/08/23.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias APICompletionBlock = (_ respone: APIResponse) -> Void

struct APIResponse {
    
    var success = false
    var data: JSON
    
    static func createAPIResponse(_ success: Bool, _ response: JSON = JSON.null) -> APIResponse {
        return APIResponse.init(success: success, data: response)
    }
    
    static func createSuccessAPIResponse(_ response: JSON = JSON.null) -> APIResponse {
        return APIResponse.init(success: true, data: response)
    }
    
    static func createFailureAPIResponse(_ response: JSON = JSON.null) -> APIResponse {
        return  APIResponse.init(success: false, data: response)
    }
    
}

class APIManager {
    
    static var shared = APIManager()
    var manager = Session.default
    var absoluteUrl = ""
    
    func getRequest(method: HTTPMethod = .get, url: String, parameters: Parameters = [:], success: @escaping APICompletionBlock) {
        showLoading()
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        print(absoluteUrl)
        manager.request(absoluteUrl, method: method).responseJSON(completionHandler: { (response) in
            if response.response?.statusCode == 200 {
                let responseJson = JSON(response.value as Any)
                dissmissLoader()
                success(APIResponse.createSuccessAPIResponse(responseJson))
            } else {
                dissmissLoader()
                success(APIResponse.createFailureAPIResponse())
            }
        })
    }
    
}
