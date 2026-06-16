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
                .fill(Color(#colorLiteral(red: 1, green: 0.9921568627, blue: 0.9764705882, alpha: 1)))
                .frame(height: 100)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.1003993247)))
                        .frame(width: 60, height: 60)
                        .cornerRadius(25)
                    Text("\(Image(systemName: Icon))")
                        .font(.custom("Inter", size: 23))
                        .fontWeight(.bold)
                }
                .padding(.trailing)
                
                VStack (alignment: .leading){
                    Text(Title)
                        .font(.custom("Inter", size: 21))
                        .fontWeight(.bold)
                    Text("\(Info)" + " " + Subtitle)
                        .font(.custom("Inter", size: 17))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                }
                
                Spacer()
                
                Text("\(Image(systemName: "chevron.right"))")
                    .font(.custom("Inter", size: 17))
                    .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                    .padding(.trailing)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileButtonCard(Title: "Reading List", Info: 67, Subtitle: "books read", Icon: "bookmark")
}
