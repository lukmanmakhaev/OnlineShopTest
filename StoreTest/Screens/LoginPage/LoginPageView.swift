//
//  LoginPageView.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 13.03.2023.
//

import SwiftUI

struct LoginPageView: View {
    @ObservedObject var viewModel: LoginPageViewModel
    @EnvironmentObject private var coordinator: Coordinator
    
    static let eyeIcon: String = "eye"
    static let eyeSlashIcon: String = eyeIcon + ".slash"
    
    
    @State var isSecure: Bool = true
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
                
                Text("Welcome back")
                    .font(.custom("Montserrat-Medium", size: 30))
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 125)
                
                TextField("First name", text: $viewModel.firstName)
                    .multilineTextAlignment(.center)
                    .frame(height: 40)
                    .background(Color(hex: "f0f0f0"))
                    .cornerRadius(50)
                    .padding(.top, 78)
                    .font(.custom("Montserrat-Medium", size: 16))
                
                HStack {
                    Text(viewModel.firstNameError)
                        .foregroundColor(Color.red)
                        .font(.custom("Montserrat-Medium", size:12))
                    Spacer()
                    
                }
                
                ZStack (alignment: .trailing) {
                    
                    if isSecure { 
                        SecureField("Password",text: $viewModel.password)
                            .multilineTextAlignment(.center)
                            .frame(height: 40)
                            .font(.custom("Montserrat-Medium", size: 16))
                            .background(Color(hex: "f0f0f0"))
                            .cornerRadius(50)
                            .padding(.top, 35)
                    } else {
                        TextField("Password",text: $viewModel.password)
                            .multilineTextAlignment(.center)
                            .frame(height: 40)
                            .font(.custom("Montserrat-Medium", size: 16))
                            .background(Color(hex: "f0f0f0"))
                            .cornerRadius(50)
                            .padding(.top, 35)
                    }

                    Button(action: { isSecure = !isSecure
                                }, label: {
                                    Image(systemName: !isSecure ? LoginPageView.eyeSlashIcon : LoginPageView.eyeIcon)
                                        .foregroundColor(.gray)
                                        .padding(.trailing)
                                })
                    .padding(.top, 35)
                }
                
                HStack {
                    Text(viewModel.passwordError)
                        .foregroundColor(Color.red)
                        .font(.custom("Montserrat-Medium", size:12))
                    Spacer()
                }
    
                Button(action: {
                    //coordinator.present(fullScreenCover: .contentView)
                    
                    viewModel.checkPassword()
                    viewModel.checkFirstName()
                    
                    if viewModel.passwordError == "" && viewModel.firstNameError == "" {
                        coordinator.present(fullScreenCover: .contentView)
                    }
                    
                }) {
                    
                    HStack {
                        Text("Login")
                    }
                    .frame(height: 60)
                    .foregroundColor(Color.white)
                    .font(.custom("Montserrat-Medium", size: 16))
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "4E55D7"))
                    .cornerRadius(20.0)
                }
                .padding(.top, 100)
                //.disabled($viewModel.isDisabled.wrappedValue)
                
                HStack {
                    Text("Dont have an account?")
                        .font(.custom("Montserrat-Medium", size: 12))
                        .foregroundColor(Color(hex: "808080"))
                    Button(action: {
                        
                        coordinator.pop()
                        
                    }, label: {
                        Text("Register now")
                            .font(.custom("Montserrat-Medium", size: 12))
                    })
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 17.4)
                Spacer()
            }
        }
        .padding()
        .navigationBarHidden(true)
    }
    
}


struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView(viewModel: LoginPageViewModel())
    }
}
