//
//  FoodListener.swift
//  FoodDots
//
//  Created by yanfeng liu on 1/12/21.
//

import Foundation
import Firebase
import UIKit
import FirebaseFirestore

class FoodListener: ObservableObject {
    
    @Published var foods: [Food] = []
    
    init() {
        downloadFoods()
    }
    
    func downloadFoods() {
        
        FirebaseReference(.Menu).getDocuments { snapshot, error in
            
            guard let snapshot = snapshot else { return }
            
            if !snapshot.isEmpty {
                
                self.foods = FoodListener.foodFromDictionary(snapshot)
            }
        }
    }
    
    static func foodFromDictionary(_ snapshot: QuerySnapshot) -> [Food] {
        
        var allFoods: [Food] = []
        
        for snapshot in snapshot.documents {
            
            let foodData = snapshot.data()
            
            allFoods.append(Food(id: foodData[kID] as? String ?? UUID().uuidString, name: foodData[kNAME] as? String ?? "Unknown", imageName: foodData[kIMAGENAME] as? String ?? "Unknown", category: Category(rawValue: foodData[kCATEGORY] as? String ?? "Fruit") ?? .Fruit, description: foodData[kDESCRIPTION] as? String ?? "Description is missing", price: foodData[kPRICE] as? Double ?? 0.0))
        }
        
        return allFoods
    }
}
