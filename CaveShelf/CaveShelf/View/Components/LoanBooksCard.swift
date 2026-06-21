//
//  LoanBooksCard.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

struct LoanBooksCard: View {
    @Binding var user: UsersModel
    @Binding var book: BooksModel
    let userVM: UserViewModel
    let lend: LendModel
    let lendVM: LendViewModel
    @Binding var bookVM: BooksViewModel
    
    @State private var showAlert = false
    @State private var showToast = false
    @State private var toastMessage = ""
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("Bg-Card"))
                .frame(height: 200)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            VStack {
                HStack (alignment: .top) {
                    Image(book.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 120)
                        .cornerRadius(10)
                        .padding(.trailing, 10)
                    VStack (alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text(book.title)
                                .font(.custom("Inter", size: 19))
                                .fontWeight(.bold)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text(book.author)
                                .font(.custom("Inter", size: 15))
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("Caption-Color"))
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text("\(Image(systemName: "calendar")) Due \(lend.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                .font(.custom("Inter", size: 13))
                                .fontWeight(.medium)
                                .foregroundStyle(lend.dueDate >= Date() ? Color("Ok-Color") : Color("No-Color"))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(lend.dueDate >= Date() ? Color("Ok-Bg") : Color("No-Bg"))
                                .cornerRadius(30)
                                .padding(.top)
                                .lineLimit(1)
                        }
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                
                Button {
                    showAlert = true
                    
                } label: {
                    Text("\(Image(systemName: "checkmark.circle.dotted")) Return")
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.medium)
                        .foregroundStyle(Color("Ok-Color"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.3)
                        .padding(.horizontal, 120)
                        .padding(.vertical, 10)
                        .glassEffect()
                }
                .buttonStyle(.plain)
                .padding(.top, 10)
                .padding(.horizontal)
                .padding(.bottom)
                .alert(isPresented: $showAlert) {
                    Alert (
                        title: Text("Return this book"),
                        message: Text("Are you sure to return this book?"),
                        primaryButton: .default(
                            Text("Yes"),
                            action: {
                                lendVM.returnBook(
                                    lendID: lend.id,
                                    book: book,
                                    user: &user,
                                    userVM: userVM,
                                    booksVM: bookVM
                                )
                            }
                        ),
                        secondaryButton: .cancel(
                            Text("Cancel"),
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    LoanBooksCard(
        user: .constant(UserViewModel().users[0]),
        book: .constant(BooksViewModel().books[0]),
        userVM: UserViewModel(),
        lend: LendViewModel(userVM: UserViewModel()).lends[2],
        lendVM: LendViewModel(userVM: UserViewModel()),
        bookVM: .constant(BooksViewModel())
    )
    
//    LoanBooksCard(
//        user: $user,
//        book: $booksVM.books[index],
//        lend: lend,
//        lendVM: lendVM
//    )

}
