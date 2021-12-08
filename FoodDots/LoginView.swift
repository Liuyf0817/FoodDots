//
//  LoginView.swift
//  FoodDots
//
//  Created by yanfeng liu on 6/12/21.
//

import SwiftUI

struct LoginView: View {
    
    @State var showingSignup = false
    @State var showingFinishReg = false
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    var body: some View {
        
        VStack {
            
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading) {
                    
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(.init(.label))
                        .opacity(0.75)
                    
                    TextField("Enter your email", text: $email)
                    
                    Divider()
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter your password", text: $password)
                    
                    Divider()
                    
                    if showingSignup {
                        
                        Text("Repeat Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(.init(.label))
                            .opacity(0.75)
                        
                        SecureField("Repeat password", text: $repeatPassword)
                        
                        Divider()
                    }
                }
                .padding(.bottom, 15)
                .animation(.easeOut(duration: 0.1))
                //End of VStack
                
                HStack {
                    
                    Spacer()
                    
                    Button {
                        
                        self.resetPassword()
                    } label: {
                        Text("Forgot Password")
                            .foregroundColor(Color.gray.opacity(0.5))
                    }

                }
                //End of HStack
                
            }
            .padding(.horizontal, 6)
            //End of VStack
            
            Button {
                
                self.showingSignup ? self.signUpUser() : self.loginUser()
            } label: {
                Text(showingSignup ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 120)
                    .padding()
            }
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 45)
            //End of Button
            
            SignUpView(showingSignup: $showingSignup)

            
        }.sheet(isPresented: $showingFinishReg) {
            
            FinishRegistrationView()
        }
        //End of VStack
    } //End of body
    
    private func loginUser() {
        
        if email != "" && password != "" {
            
            FBUser.loginUserWith(email: email, password: password) { error, isEmailVerified in
                
                if error != nil {
                    
                    print("error loging in the user: ", error!.localizedDescription)
                    
                    return
                }
                
                if FBUser.currentUser() != nil && FBUser.currentUser()!.onBoarding {
                    
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    
                    self.showingFinishReg.toggle()
                }
            }
        }
    }
    
    private func signUpUser() {
        
        if email != "" && password != "" && repeatPassword != "" {
            
            if password == repeatPassword {
                
                FBUser.registerUserWith(email: email, password: password) { error in
                    
                    if error != nil {
                        print("Error registering user: ", error!.localizedDescription)
                        
                        return
                    }
                    print("use has been created")
                }
            } else {
                print("passwords don't match")
            }
        } else {
            print("Email and password must be set")
        }
        
    }
    
    private func resetPassword() {
        
        if email != "" {
            
            FBUser.resetPassword(email: email) { error in
                
                if error != nil {
                    print("error sending reset password, ", error!.localizedDescription)
                    
                    return
                }
                
                print("Please check your email")
            }
        } else {
            //notify the user
            print("email is empty")
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct SignUpView: View {
    
    @Binding var showingSignup: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            
            HStack(spacing: 8) {
                
                Text("Don't have an account?")
                    .foregroundColor(Color.gray.opacity(0.5))
                
                Button {
                    
                    self.showingSignup.toggle()
                } label: {
                    Text("Sign Up")
                    
                }
                .foregroundColor(.blue)

            }
            //End of HStack
        }
        //End of VStack
    }
}
