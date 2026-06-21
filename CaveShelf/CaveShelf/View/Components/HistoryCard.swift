//
//  HistoryCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

struct HistoryCard: View {
    let book: BooksModel
    let lend: LendModel
    
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
                            .font(.custom("Inter", size: 19))
                            .fontWeight(.bold)
                    }
                    ScrollView (.horizontal, showsIndicators: false) {
                        Text(book.author)
                            .font(.custom("Inter", size: 15))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Caption-Color"))
                    }
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        Text("\(Image(systemName: "clock")) Returned \(lend.returnDate?.formatted(date: .abbreviated, time: .omitted) ?? "to us please")")
                            .font(.custom("Inter", size: 13))
                            .fontWeight(.medium)
                            .foregroundStyle(Color("Caption-Color"))
                            .padding(.top)
                    }
                }
                Spacer()
                Text("\(Image(systemName: "checkmark.circle.dotted"))")
                    .font(.custom("Inter", size: 30))
                    .foregroundStyle(Color("Ok-Color"))
                    .padding(.trailing, 10)
            }
            .padding(.horizontal)
            .frame(height: 130)
        }
    }
}

#Preview {
    HistoryCard(book: BooksViewModel().books[1], lend: LendViewModel(userVM: UserViewModel()).lends[2])
}
