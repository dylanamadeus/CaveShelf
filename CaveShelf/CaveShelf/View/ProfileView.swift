//
//  ProfileView.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 15/06/26.
//

import SwiftUI

struct ProfileView: View {
//    let user: UsersModel
    @Binding var user: UsersModel
    let lendVM: LendViewModel
    @Binding var booksVM: BooksViewModel
    
    @State private var selectedView: String = "Read"
    var onRead: () -> Void = {}
    var onLoan: () -> Void = {}
    var onSignOut: () -> Void = {}
    
    var body: some View {
        ZStack {
            Color("Bg-Color").ignoresSafeArea()
            VStack {
                HStack {
                    Text("Profile")
                        .font(.custom("DMSerifDisplay-Regular", size: 29))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Spacer()
                    Button {
                        onSignOut()
                    } label: {
                        Text("\(Image(systemName: "rectangle.portrait.and.arrow.right")) Sign Out")
                            .font(.custom("Inter", size: 15))
                            .fontWeight(.regular)
                            .foregroundStyle(Color("No-Color"))
                            .padding(10)
                            .glassEffect()
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .buttonStyle(.plain)
                }
                
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 150)
                        .glassEffect()
                    Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
                        .font(.custom("DMSerifDisplay-Regular", size: 51))
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.top)
                
                Text("\(user.firstName) \(user.lastName)")
                    .font(.custom("Inter", size: 23))
                    .fontWeight(.semibold)
                    .padding(.bottom, 50)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                
                ScrollView(.vertical, showsIndicators: false) {
                    HStack {
                        ProfileInfoCard(Info: lendVM.totalRead(for: user), Title: "Read")
                        ProfileInfoCard(Info: lendVM.userLoan(for: user), Title: "On Loan")
                    }
                    .padding(.bottom)
                
                    Button {
                        onRead()
                    } label: {
                        ProfileButtonCard(Title: "Reading List", Info: lendVM.totalRead(for: user), Subtitle: "books read", Icon: "text.book.closed.fill")
                    }
                    .buttonStyle(.plain)
                    Button {
                        onLoan()
                    } label: {
                        ProfileButtonCard(Title: "On Loan", Info: lendVM.userLoan(for: user), Subtitle: "books on loan", Icon: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView(user: .constant(UserViewModel().users[0]), lendVM: LendViewModel(userVM: UserViewModel()), booksVM: .constant(BooksViewModel()))
}
