//
//  BooksCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 10/06/26.
//

import SwiftUI

struct BooksCard: View {
    let book: BooksModel
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Bg-Card"))
                .frame(height: 130)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            HStack {
                Image(book.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 105)
                    .cornerRadius(10)
                    .padding(.trailing,5)
                VStack (alignment: .leading) {
                    ScrollView (.horizontal, showsIndicators: false) {
                        Text(book.title)
                            .font(.custom("Inter", size: 17))
                            .fontWeight(.bold)
                    }
                    ScrollView (.horizontal, showsIndicators: false) {
                        Text(book.author)
                            .font(.custom("Inter", size: 13))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Caption-Color"))
                    }
                }
                Spacer()
                VStack {
                    Spacer()
                    Text(book.status ? "Available" : "On Loan")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.medium)
                        .foregroundStyle(book.status ? Color("Ok-Color") : Color("No-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background(book.status ? Color("Ok-Bg") : Color("No-Bg"))
                        .cornerRadius(30)
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
            .frame(height: 130)
        }
    }
}

#Preview {
    BooksCard(book: BooksViewModel().books[1])
}
