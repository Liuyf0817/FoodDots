//
//  FoodDotsApp.swift
//  FoodDots
//
//  Created by yanfeng liu on 30/11/21.
//

import SwiftUI
import Firebase

@main
struct FoodDotsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
