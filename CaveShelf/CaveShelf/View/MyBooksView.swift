//
//  MyBooksView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

struct MyBooksView: View {
    @Binding var user: UsersModel
    let lendVM: LendViewModel
    @State var booksVM: BooksViewModel
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.9333333333, alpha: 1)).ignoresSafeArea()
            VStack (alignment: .leading) {
                Text("My Books")
                    .font(.custom("DMSerifDisplay-Regular", size: 29))
                    .fontWeight(.bold)
                
                Picker("MyBooks", selection: $selectedTab) {
                    Text("On Loan").tag(0)
                    Text("History").tag(1)
                }
                .pickerStyle(.segmented)
                
                if selectedTab == 0 {
                    OnLoanView(user: $user, lendVM: lendVM, booksVM: $booksVM)
                } else {
                    HistoryView(user: $user, lendVM: lendVM, booksVM: booksVM)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct OnLoanView: View {
    @Binding var user: UsersModel
    let lendVM: LendViewModel
    @Binding var booksVM: BooksViewModel
    
    private var activeLends: [LendModel] {
        lendVM.lends.filter { lend in
            lend.userID == user.id && !lend.isReturn
        }
    }
    
    var body: some View {
        VStack {
            LoanCard(user: user, lendsVM: lendVM)
                .padding(.vertical)
            ScrollView(.vertical, showsIndicators: false) {
                if(activeLends.count >= 1) {
                    ForEach(activeLends) { lend in
                        if let index = booksVM.books.firstIndex(where: {
                            $0.id == lend.bookID
                        }) {
                            LoanBooksCard(
                                user: $user,
                                book: $booksVM.books[index],
                                lend: lend,
                                lendVM: lendVM
                            )
                        }
                    }
                } else {
                    Text("\(Image(systemName: "text.book.closed.fill"))")
                        .font(.system(size: 100))
                        .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                        .padding()
                        .padding(.top, 100)
                    Text("You'll find your active loans here")
                        .font(.custom("Inter", size: 21))
                        .fontWeight(.medium)
                        .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                        .padding(10)
                    Text("You can see the books you're loaning from your On Loan")
                        .font(.custom("Inter", size: 13))
                        .fontWeight(.light)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 1)))
                }
            }
        }
    }
}

struct HistoryView: View {
    @Binding var user: UsersModel
    let lendVM: LendViewModel
    let booksVM: BooksViewModel
    
    private var activeLends: [LendModel] {
        lendVM.lends.filter { lend in
            lend.userID == user.id && lend.isReturn
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if(activeLends.count >= 1) {
                ForEach(activeLends) { lend in
                    if let book = booksVM.books.first(where: { $0.id == lend.bookID }) {
                        HistoryCard(book: book, lend: lend)
                    }
                }
            } else {
                Text("\(Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90"))")
                    .font(.system(size: 100))
                    .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                    .padding()
                    .padding(.top, 200)
                    .frame(width: 362)
                Text("You'll find your history here")
                    .font(.custom("Inter", size: 21))
                    .fontWeight(.medium)
                    .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                    .padding(10)
                Text("You can see the books you've loaned from your History")
                    .font(.custom("Inter", size: 13))
                    .fontWeight(.light)
                    .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 1)))
            }
        }
    }
}

#Preview {
    MyBooksView(user: .constant(UserViewModel().users[0]), lendVM: LendViewModel(userVM: UserViewModel()), booksVM: BooksViewModel(), selectedTab: .constant(0))
}
