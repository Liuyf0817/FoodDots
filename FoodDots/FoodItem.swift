//
//  FoodItem.swift
//  FoodDots
//
//  Created by yanfeng liu on 1/12/21.
//

import SwiftUI

struct FoodItem: View {
    
    var food: Food
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Image(food.imageName)
                .resizable()
                .renderingMode(.original)
                .aspectRatio( contentMode: .fill)
                .frame(width: 300, height: 170)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            VStack(alignment: .leading, spacing: 5) {
                
                Text(food.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                
                Text(food.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height: 40)
            }
        }
    }
}

struct FoodItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodItem(food: foodData[0])
    }
}
