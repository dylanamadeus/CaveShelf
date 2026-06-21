//
//  ProfileInfoCard.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 15/06/26.
//

import SwiftUI

struct ProfileInfoCard: View {
    let Info: Int
    let Title: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Bg-Card"))
                .frame(height: 100)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            VStack {
                Text("\(Info)")
                    .font(.custom("Inter", size: 25))
                    .fontWeight(.bold)
                    .foregroundStyle(Color("Golden-Color"))
                Text(Title)
                    .font(.custom("Inter", size: 13))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("Caption-Color"))
            }
        }
    }
}

#Preview {
    ProfileInfoCard(Info: 67, Title: "Read")
}
