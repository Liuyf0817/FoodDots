//
//  FoodDetail.swift
//  FoodDots
//
//  Created by yanfeng liu on 1/12/21.
//

import SwiftUI

struct FoodDetail: View {
    
    @State private var showingAlert = false
    @State private var showingLogin = false
    
    var food: Food
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            ZStack(alignment: .bottom) {
                
                Image(food.imageName)
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(food.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                } //End of HStack
            } //End of ZStack
            .listRowInsets(EdgeInsets())
            
            Text(food.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack {
                Spacer()
                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, food: self.food)
                Spacer()
            }
        } //End of Scroll view
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(false)
        .alert(isPresented: $showingAlert) {
            
            Alert(title: Text("Added to Basket!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail(food: foodData.first!)
    }
}

struct OrderButton: View {
    
    @ObservedObject var basketListener = BasketListener()
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    
    var food: Food
    
    var body: some View {
        
        Button {
            
            if FBUser.currentUser() != nil && FBUser.currentUser()!.onBoarding {
                
                self.showAlert.toggle()
                self.addItemToBasket()
            } else {
                self.showLogin.toggle()
            }
            
        } label: {
            
            Text("Add to basket")
        }
        .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(.blue)
        .cornerRadius(10)
        .sheet(isPresented: self.$showLogin) {
            
            if FBUser.currentUser() != nil {
                FinishRegistrationView()
            } else {
                LoginView()
            }
        }
    }
    
    private func addItemToBasket() {
        
        var orderBasket: OrderBasket!
        
        //check if user has basket
        if self.basketListener.orderBasket != nil {
            
            orderBasket = self.basketListener.orderBasket
        } else {
            
            orderBasket = OrderBasket()
            orderBasket.ownerId = FBUser.currentId()
            orderBasket.id = UUID().uuidString
        }
        
        orderBasket.add(self.food)
        orderBasket.saveBasketToFirestore()
    }
}
