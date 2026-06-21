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
    
    init() {
        loadUsers()
    }
    
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
    
    func createUser(_ user: UsersModel) -> Bool {
        guard !users.contains(where: { $0.username == user.username }) else {
            return false
        }

        guard !user.username.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard !user.firstName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard !user.lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }

        guard user.password.count >= 8 else {
            return false
        }

        users.append(user)
        saveUsers()
        return true
    }
    
    func decreaseMaxLoan(for user: inout UsersModel) {
        guard let index = users.firstIndex(where: { $0.id == user.id }) else {
            return
        }

        users[index].maxLoan -= 1
        user = users[index]
        
        saveUsers()
    }
    
    func saveUsers() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: "users")
            print("Users saved")
        }
    }
    
    func loadUsers() {
        if let data = UserDefaults.standard.data(forKey: "users"),
           let decoded = try? JSONDecoder().decode([UsersModel].self, from: data) {
            users = decoded
        }
    }
}
