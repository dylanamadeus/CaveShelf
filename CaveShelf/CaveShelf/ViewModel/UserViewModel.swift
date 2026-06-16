//
//  UserViewModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import Foundation
import Observation

@Observable
final class UserViewModel {
    var users: [UsersModel] = [
        UsersModel(
            username: "dylanamadeus",
            firstName: "Dylan",
            lastName: "Amadeus",
            password: "dylanamadeus",
            maxLoan: 3
        ),
        UsersModel(
            username: "nadineamanda",
            firstName: "Nadine",
            lastName: "Amanda",
            password: "nadineamanda",
            maxLoan: 3
        )
    ]
}
