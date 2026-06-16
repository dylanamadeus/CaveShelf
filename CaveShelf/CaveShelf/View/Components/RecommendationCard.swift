//
//  RecommendationCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import SwiftUI

struct RecommendationCard: View {
    let book: BooksModel
    var body: some View {
        ZStack {
            Image(book.coverImage)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
                .clipped()
                .blur(radius: 2)
            
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 1)))
                .opacity(0.5)
                .frame(height: 203)
                .cornerRadius(20)
            
            HStack {
                VStack (alignment: .leading){
                    Spacer()
                    Text("Recommendation")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 2)
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.black)
                        .foregroundStyle(.white)
                        .background(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                        .cornerRadius(30)
                    Text(book.title)
                        .font(.custom("DMSerifDisplay-Regular", size: 29))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text(book.author)
                        .font(.custom("Inter", size: 17))
                        .foregroundStyle(Color(#colorLiteral(red: 0.9294117647, green: 0.9098039216, blue: 0.8784313725, alpha: 1)))
                }
                .padding()
                .frame(height: 200)
                Spacer()
            }
        }
    }
}

#Preview {
    RecommendationCard(book: BooksViewModel().books[0])
}
