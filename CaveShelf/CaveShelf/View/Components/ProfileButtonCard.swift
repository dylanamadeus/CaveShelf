//
//  ProfileButtonCard.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 15/06/26.
//

import SwiftUI

struct ProfileButtonCard: View {
    let Title: String
    let Info: Int
    let Subtitle: String
    let Icon: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Bg-Card"))
                .frame(height: 80)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color("Icon-Card"))
                        .frame(width: 50, height: 50)
                        .cornerRadius(20)
                    Text("\(Image(systemName: Icon))")
                        .font(.custom("Inter", size: 21))
                }
                .padding(.trailing)
                
                VStack (alignment: .leading){
                    Text(Title)
                        .font(.custom("Inter", size: 17))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text("\(Info)" + " " + Subtitle)
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Caption-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                
                Spacer()
                
                Text("\(Image(systemName: "chevron.right"))")
                    .font(.custom("Inter", size: 17))
                    .foregroundStyle(Color("Caption-Color"))
                    .padding(.trailing)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileButtonCard(Title: "Reading List", Info: 67, Subtitle: "books read", Icon: "bookmark")
}
