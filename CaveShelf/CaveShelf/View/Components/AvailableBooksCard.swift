//
//  AvailableBooksCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import SwiftUI

struct AvailableBooksCard: View {
    let book: BooksModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Image(book.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 165, height: 220)
                    .cornerRadius(15)
                
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.2)
                    .frame(width: 165, height: 220)
                    .cornerRadius(15)
            }
            
            Text(book.title)
                .font(.custom("Inter", size: 17))
                .fontWeight(.semibold)
            
            Text(book.author)
                .font(.custom("Inter", size: 13))
                .fontWeight(.medium)
                .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
        }
    }
}

#Preview {
    AvailableBooksCard(book: BooksViewModel().books[1])
}
