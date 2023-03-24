//
//  Users.swift
//  StoreTest
//
//  Created by Lukman Makhaev on 23.03.2023.
//

import Foundation
import SwiftUI
import Combine

class Users: ObservableObject {
    
    @Published var users: [User] = [User(firstName: "lukman", lastName: "makhaev", email: "lukmanmakhaev@gmail.com", password: "123")]
    
}
