//
//  User.swift
//  FruitDots
//
//  Created by yanfeng liu on 19/11/21.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    var id: String
    var email: String
    var firstname: String
    var lastname: String
    var fullname: String
    var currentUser: String
    var fullAddress: String
    var phoneNumber: String
    var onBoard: Bool
}
