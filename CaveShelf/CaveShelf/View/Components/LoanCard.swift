//
//  LoanCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

struct LoanCard: View {
    @Binding var user: UsersModel
    @Binding var lendsVM: LendViewModel
    
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
            HStack {
                VStack {
                    Text("\(lendsVM.userLoan(for: user))")
                        .font(.custom("Inter", size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Golden-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                    
                    Text("Active Loans")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Caption-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                }
                .frame(width: 100)
                Spacer()
                Divider()
                    .frame(width: 0.5, height: 80)
                    .overlay(.gray)
                Spacer()
                VStack {
                    Text("\(user.maxLoan)")
                        .font(.custom("Inter", size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Ok-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                    
                    Text("Max Allowed")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Caption-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
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
                        .foregroundStyle(Color("No-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                    
                    Text("Overdue")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.semibold)
                        .foregroundStyle(Color("Caption-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
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
    LoanCard(user: .constant(userVM.users[0]), lendsVM: .constant(lendVM))
}
