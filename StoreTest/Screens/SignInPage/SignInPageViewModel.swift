//
//  SignInPageViewModel.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 12.03.2023.
//

import Foundation
import SwiftUI

class SignInViewPageModel: ObservableObject {
    
    @StateObject var users = Users()
    

    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var isDisabled: Bool = true
    @Published var email: String = "" {
        didSet {
            if self.email.isEmpty {
                self.emailError = "Email required"
                self.isDisabled = true
            } else if !self.email.isValidEmail {
                self.emailError = "Invalid email"
                self.isDisabled = true
            } else if isExisting(value: email, in: users.users)! {
                self.emailError = "This email is already registered"
                self.isDisabled = true
            } else {
                self.emailError = ""
                self.isDisabled = false
            }
        }
    }
    var emailError: String = ""
    
    func isExisting(value searchValue: String, in array: [User]) -> Bool? {
        for (_, value) in array.enumerated() {
            if value.email == searchValue {
                return true
            }
        }
     
        return false
    }
}
