//
//  LoginPageViewModel.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 13.03.2023.
//

import Foundation
import SwiftUI


class LoginPageViewModel: ObservableObject {
    
    var users = Users()
    
    @Published var firstName: String = ""  
    @Published var password: String = ""

    @Published var isDisabled: Bool = true
    @Published var firstNameError: String = ""
    @Published var passwordError: String = ""

    func checkFirstName() {
        if self.firstName.isEmpty {
            self.firstNameError = "Firstname is required"
            self.isDisabled = true
        } else if !isExisting(value: firstName, in: users.users)! {
            self.firstNameError = "There is no account with this Firstname"
            self.isDisabled = true
        } else {
            self.firstNameError = ""
            self.isDisabled = false
        }
    }
    
    func checkPassword() {
        if self.password.isEmpty {
            self.passwordError = "Password is required"
        } else if !isCorrectPassword(value: password, in: users.users)! {
            self.passwordError = "Password is incorrect"
        } else {
            self.passwordError = ""
        }
    }
    
    
    func isExisting(value searchValue: String, in array: [User]) -> Bool? {
        for (_, value) in array.enumerated() {
            if value.firstName == searchValue {
                return true
            }
        }
        return false
    }
    
    func isCorrectPassword(value searchValue: String, in array: [User]) -> Bool? {
        for (_, value) in array.enumerated() {
            if value.password == searchValue {
                return true
            }
        }
        return false
    }
}
