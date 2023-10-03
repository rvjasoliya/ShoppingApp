import Foundation
import SwiftyJSON

public class CategoriesProduct {
    
	public let products : [Products]?
	public let total : Int?
	public let skip : Int?
	public let limit : Int?

    init(json: JSON) {
        self.products = json["products"].arrayValue.map({ Products.init(json: $0)})
        self.total = json["total"].int
        self.skip = json["skip"].int
        self.limit = json["limit"].int
    }

}
