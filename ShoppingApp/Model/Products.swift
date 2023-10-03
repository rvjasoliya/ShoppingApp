import Foundation
import SwiftyJSON

public class Products {
    
	public let id : Int?
	public let title : String?
	public let description : String?
	public let price : Int?
	public let discountPercentage : Double?
	public let rating : Double?
	public let stock : Int?
	public let brand : String?
	public let category : String?
	public let thumbnail : String?
	public let images : [String]?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.title = json["title"].string
        self.description = json["description"].string
        self.price = json["price"].int
        self.discountPercentage = json["discountPercentage"].double
        self.rating = json["rating"].double
        self.stock = json["stock"].int
        self.brand = json["brand"].string
        self.category = json["category"].string
        self.thumbnail = json["thumbnail"].string
        self.images = json["images"].arrayObject as? [String]
    }

}
