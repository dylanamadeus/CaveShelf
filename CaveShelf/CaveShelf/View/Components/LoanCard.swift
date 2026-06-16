//
//  LoanCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

struct LoanCard: View {
    let user: UsersModel
    let lendsVM: LendViewModel
    
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
                VStack {
                    Text("\(lendsVM.userLoan(for: user))")
                        .font(.custom("Inter", size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                    
                    Text("Active Loans")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                }
                .frame(width: 100)
                Spacer()
                Divider()
                    .frame(width: 0.5, height: 80)
                    .overlay(.gray)
                Spacer()
                VStack {
                    Text("3")
                        .font(.custom("Inter", size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)))
                    
                    Text("Max Allowed")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                }
                .frame(width: 100)
                Spacer()
                Divider()
                    .frame(width: 0.5, height: 80)
                    .overlay(.gray)
                Spacer()
                VStack {
                    Text("\(lendsVM.overdueLoan(for: user))")
                        .font(.custom("Inter", size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.2745098039, blue: 0.168627451, alpha: 1)))
                    
                    Text("Overdue")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                }
                .frame(width: 100)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    let userVM = UserViewModel()
    let lendVM = LendViewModel(userVM: userVM)
    LoanCard(user: userVM.users[0], lendsVM: lendVM)
}
