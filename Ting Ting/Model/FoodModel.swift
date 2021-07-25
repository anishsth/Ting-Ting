//
//  FoodModel.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 25/07/21.
//

import Foundation
import UIKit

class FoodModel {
    var id: String!
    var image: UIImage?
    var itemName: String = ""
    var itemDescription: String = ""
    var itemQuantity: String = ""
    var price: String = ""
    var currentOrderCount: Int = 0
    var displayPrice: String {
        return "$" + price
    }
    var totalAmount: Float {
        return ((Float(price) ?? 0) * Float(currentOrderCount))
    }
}
