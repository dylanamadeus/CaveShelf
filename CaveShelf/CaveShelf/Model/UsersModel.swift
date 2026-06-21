//
//  UsersModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import Foundation

struct UsersModel: Identifiable, Codable {
    var id: String { username }
    let username: String
    let firstName: String
    let lastName: String
    let password: String
    var maxLoan: Int
}
