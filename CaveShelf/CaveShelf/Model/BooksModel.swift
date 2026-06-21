//
//  BooksModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 10/06/26.
//

import Foundation

struct BooksModel: Identifiable, Hashable, Codable {
    var id: String { title }
    let title: String
    let author: String
    let coverImage: String
    let pages: Int
    let year: Int
    let about: String
    
    var status: Bool
}
