//
//  FirebaseReference.swift
//  FruitDots
//
//  Created by yanfeng liu on 29/11/21.
//

import Foundation
import FirebaseFirestore

enum FBCollectionReference: String {
    case User
    case Menu
    case Order
    case Basket
}

func FirebaseReference(_ collectionReference: FBCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
