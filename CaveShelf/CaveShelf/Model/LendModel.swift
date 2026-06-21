//
//  LendModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import Foundation

struct LendModel: Identifiable, Codable {
    var id = UUID()
    let userID: String
    let bookID: String
    let borrowDate: Date
    let dueDate: Date
    var returnDate: Date?
    var isReturn: Bool
}
