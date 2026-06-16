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
                .fill(Color(#colorLiteral(red: 1, green: 0.9921568627, blue: 0.9764705882, alpha: 1)))
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
                    .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                Text(Title)
                    .font(.custom("Inter", size: 13))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
            }
        }
    }
}

#Preview {
    ProfileInfoCard(Info: 67, Title: "Read")
}
