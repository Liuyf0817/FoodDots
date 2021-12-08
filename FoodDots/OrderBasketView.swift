//
//  OrderBasketView.swift
//  FoodDots
//
//  Created by yanfeng liu on 6/12/21.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    var body: some View {
        
        NavigationView {
            
            List {
                Section {
                    ForEach(self.basketListener.orderBasket?.items ?? []) { food in
                        
                        HStack {
                            Text(food.name)
                            Spacer()
                            Text("$\(food.price.clean)")
                        } //End of HStack
                    } //End of ForEach
                    .onDelete { (indexSet) in
                        self.deleteItems(at: indexSet)
                    }
                }
                
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Place Order")
                    }
                }
                .disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            } //End of List
            .navigationTitle("Order")
            .listStyle(GroupedListStyle())
        } //End of Navigation view
    }
    
    func deleteItems(at offsets: IndexSet) {
        
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
