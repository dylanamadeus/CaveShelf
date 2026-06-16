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
                .fill(Color(#colorLiteral(red: 1, green: 0.9921568627, blue: 0.9764705882, alpha: 1)))
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
                    Text(book.title)
                        .font(.custom("Inter", size: 17))
                        .fontWeight(.bold)
                    Text(book.author)
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                }
                Spacer()
                VStack {
                    Spacer()
                    Text(book.status ? "Available" : "On Loan")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.medium)
                        .foregroundStyle(book.status ? Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)) : Color(#colorLiteral(red: 0.768627451, green: 0.2745098039, blue: 0.168627451, alpha: 1)))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .background(book.status ? Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)) : Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 0.2)))
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
