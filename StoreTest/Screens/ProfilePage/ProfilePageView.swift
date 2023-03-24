//
//  ProfilePageView.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 14.03.2023.
//

import SwiftUI

struct ProfilePageView: View {
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
            
        ZStack {
            Color(hex: "FAF9FF")
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                
                ProfileNavBar()
                
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.green)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    .padding(.top)
                
                Text("Change photo")
                    .font(.custom("Montserrat-Medium", size: 10))
                    .foregroundColor(.gray)
                
                Text("Satria Adhi Pradana")
                    .font(.custom("Montserrat-Bold", size: 16))
                    .foregroundColor(Color(hex: "3F3F3F"))
                    .padding(.top, 15)
                
                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        
                        Text("Upload item")
                            .padding()
                    }
                    .frame(height: 50)
                    .foregroundColor(Color.white)
                    .font(.custom("Montserrat-Medium", size: 16))
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "4E55D7"))
                    .cornerRadius(20.0)
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                
                VStack {
                    SettingsItemView(icon: "card", name: "Trade store", balance: "", arrow: "chevron.right")
               
                SettingsItemView(icon: "card", name: "Payment method",balance: "", arrow: "chevron.right")
                SettingsItemView(icon: "card", name: "Balance", balance: "$1593")
                SettingsItemView(icon: "card", name: "Trade history", balance: "", arrow: "chevron.right")
                SettingsItemView(icon: "restore", name: "Restore purchase", balance: "", arrow: "chevron.right")
                SettingsItemView(icon: "help", name: "Help", balance: "")
                SettingsItemView(icon: "logout", name: "Log out", balance: "")
                        .onTapGesture {
                            coordinator.fullScreenCoverDismiss()
                        }
                }
                //coordinator.fullScreenCoverDismiss()

                
            }
            .padding(.bottom, 90)
        }
          
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}

struct ProfileNavBar: View {
    var body: some View {
        HStack (alignment: .center){
            Button (action: {
                
            }, label: {
                Image("back").resizable().frame(width: 22, height: 22)
            })
            .frame(alignment: .leading)
            
            Text("Profile")
                .font(.custom("Montserrat-Bold", size: 20))
                .frame(maxWidth: .infinity)
                .padding(.trailing, 30)
        }
        .padding(.horizontal)
    }
}

struct SettingsItemView: View {
    var icon: String
    var name: String
    var balance: String
    var arrow: String?
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(10)
                .background(Color(hex: "EEEFF4"))
                .clipShape(Circle())
            
            Text(name)
                .font(.custom("Montserrat-Medium", size: 18))
                .padding(.leading, 5)
            
            Spacer()
            
            ZStack {
                Text(balance)
                    .font(.custom("Montserrat-Medium", size: 18))
                
                Image(systemName: arrow != nil ? arrow! : "")
            }
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}
