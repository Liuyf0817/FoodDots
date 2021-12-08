//
//  OrderBasket.swift
//  FoodDots
//
//  Created by yanfeng liu on 2/12/21.
//

import Foundation
import Firebase

class OrderBasket: Identifiable {
    
    var id: String!
    var ownerId: String!
    var items: [Food] = []
    
    var total: Double {
        
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0.0
        }
    }
    
    func add(_ item: Food) {
        items.append(item)
    }
    
    func remove(_ item: Food) {
        
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func emptyBasket() {
        self.items = []
        
        //save to Firebase
        saveBasketToFirestore()
    }
    
    func saveBasketToFirestore() {
        FirebaseReference(.Basket).document(self.id).setData(basketDictionaryFrom(self))
    }
}

func basketDictionaryFrom(_ basket: OrderBasket) -> [String: Any] {
    
    var allFoodIds: [String] = []
    
    for food in basket.items {
        allFoodIds.append(food.id)
    }
    
    return NSDictionary(objects: [basket.id,
                                  basket.ownerId,
                                 allFoodIds], forKeys: [kID as NSCopying,
                                                       kOWNERID as NSCopying,
                                                        kFOODIDS as NSCopying]) as! [String: Any]
}
