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
            
                VStack (alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text(book.title)
                            .font(.custom("Inter", size: 17))
                            .fontWeight(.semibold)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text(book.author)
                            .font(.custom("Inter", size: 13))
                            .fontWeight(.medium)
                            .foregroundStyle(Color("Caption-Color"))
                    }
                }
            
            .frame(width: 165)
        }
    }
}

#Preview {
    AvailableBooksCard(book: BooksViewModel().books[1])
}
