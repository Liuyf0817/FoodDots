//
//  ContentView.swift
//  FoodDots
//
//  Created by yanfeng liu on 30/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var dataListener = FoodListener()
    @State private var showingBasket = false
    
    var categories: [String: [Food]] {
        
        .init(grouping: dataListener.foods, by: {$0.category.rawValue})
    }
    
    var body: some View {
                
        NavigationView {
            
            List(categories.keys.sorted(), id: \String.self) { key in
                
                FoodRow(categoryName: "\(key)", foods: self.categories[key]!)
                    .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
            
                .navigationBarTitle(Text("FoodDots"))
                .navigationBarItems(leading:

                    Button(action: {
                        //code

                    FBUser.logOutCurrentUser { error in
                        print("error loging out user, ", error?.localizedDescription)
                    }
//                    createMenu()
                    }, label: {
                        Text("Log Out")
                    })
                , trailing:

                    Button(action: {

                    self.showingBasket.toggle()
                    }, label: {
                        Image("basket")
                    })
                    .sheet(isPresented: $showingBasket, content: {
                    
                    if FBUser.currentUser() != nil && FBUser.currentUser()!.onBoarding {
                        
                        OrderBasketView()
                    } else if FBUser.currentUser() != nil {
                        
                        FinishRegistrationView()
                    } else {
                        LoginView()
                    }
                        
                })
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
