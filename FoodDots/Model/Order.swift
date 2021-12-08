//
//  Order.swift
//  FruitDots
//
//  Created by yanfeng liu on 29/11/21.
//

import Foundation

class Order: Identifiable {
    var id: String!
    var customerId: String!
    var orderItems: [Food] = []
    var amount: Double!
    var customerName: String!
    var isCompleted: Bool!
    
//    var foodIds: [String]
//    var ownerId: String
    
    func saveOrderToFirestore() {
        
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) {
            error in
            
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
}

func orderDictionaryFrom(_ order: Order) -> [String : Any] {
    
    var allFoodIds: [String] = []
    
    for food in order.orderItems {
        
        allFoodIds.append(food.id)
    }
    
    return NSDictionary(objects: [
                            order.id,
                            order.customerId,
                            allFoodIds,
                            order.amount,
                            order.customerName,
                            order.isCompleted],
                        forKeys: [
                            kID as NSCopying,
                            kCUSTOMERID as NSCopying,
                            kFOODIDS as NSCopying,
                            kAMOUNT as NSCopying,
                            kCUSTOMERNAME as NSCopying,
                            kISCOMPLETED as NSCopying]) as! [String: Any]
}
