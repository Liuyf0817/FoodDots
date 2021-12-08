//
//  BasketListener.swift
//  FoodDots
//
//  Created by yanfeng liu on 6/12/21.
//

import Foundation
import Firebase

class BasketListener: ObservableObject {
    
    @Published var orderBasket: OrderBasket!
    
    init() {
        downloadBasket()
    }
    
    func downloadBasket() {
        
        if FBUser.currentUser() != nil {
            
            FirebaseReference(.Basket).whereField(kOWNERID, isEqualTo: FBUser.currentId()).addSnapshotListener { (snapshot, error) in
                
                guard let snapshot = snapshot else { return }
                
                if !snapshot.isEmpty {
                    
                    let basketData = snapshot.documents.first!.data()
                    
                    getFoodsFromFirestore(withIds: basketData[kFOODIDS] as? [String] ?? []) { (allFoods) in
                        
                        let basket = OrderBasket()
                        basket.ownerId = basketData[kOWNERID] as? String
                        basket.id = basketData[kID] as? String
                        basket.items = allFoods
                        self.orderBasket = basket
                    }
                }
            }
        }
        
    }
}

func getFoodsFromFirestore(withIds: [String], completion: @escaping (_ foodArray: [Food]) -> Void) {
    
    var count = 0
    var foodArray: [Food] = []
    
    if withIds.count == 0 {
        completion(foodArray)
        return
    }
    
    for foodId in withIds {
        
        FirebaseReference(.Menu).whereField(kID, isEqualTo: foodId).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                let foodData = snapshot.documents.first!
                
                foodArray.append(Food(id: foodData[kID] as? String ?? UUID().uuidString, name: foodData[kNAME] as? String ?? "Unknown", imageName: foodData[kIMAGENAME] as? String ?? "Unknown", category: Category(rawValue: foodData[kCATEGORY] as? String ?? "Fruit") ?? .Fruit, description: foodData[kDESCRIPTION] as? String ?? "Description is missing", price: foodData[kPRICE] as? Double ?? 0.0))
                
                count += 1
            } else {
                print("have no food")
                completion(foodArray)
            }
            
            if count == withIds.count {
                completion(foodArray)
            }
        }
    }
}
