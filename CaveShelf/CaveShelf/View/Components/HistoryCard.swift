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
                        .font(.custom("Inter", size: 19))
                        .fontWeight(.bold)
                    Text(book.author)
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                    
                    Text("\(Image(systemName: "clock")) Returned \(lend.returnDate?.formatted(date: .abbreviated, time: .omitted) ?? "to us please")")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.medium)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                        .padding(.top)
                }
                Spacer()
                Text("\(Image(systemName: "checkmark.circle.dotted"))")
                    .font(.custom("Inter", size: 30))
                    .foregroundStyle(Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)))
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
