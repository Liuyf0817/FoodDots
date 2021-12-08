//
//  FoodRow.swift
//  FoodDots
//
//  Created by yanfeng liu on 1/12/21.
//

import SwiftUI

struct FoodRow: View {
    
    var categoryName: String
    var foods: [Food]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(self.categoryName)
                .font(.title)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack {
                    ForEach(self.foods) { food in
                        
                        NavigationLink {
                          FoodDetail(food: food)
                        } label: {
                            
                            FoodItem(food: food)
                                .frame(width: 300)
                                .padding(.trailing, 30)
                        }

                    }
                }
            }
        }
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow(categoryName: "Fruits", foods: foodData)
    }
}
