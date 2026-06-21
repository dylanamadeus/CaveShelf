//
//  BooksView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import SwiftUI

struct BooksView: View {
    @Binding var book: BooksModel
    @Binding var user: UsersModel
    @Binding var lendVM: LendViewModel
    @Binding var bookVM: BooksViewModel
    
    @State private var showAlert = false
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .top){
                Color("Bg-Color").ignoresSafeArea()
                Image(book.coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
                    .blur(radius: 7)
                    .ignoresSafeArea()
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.5)
                    .frame(height: 300)
                    .ignoresSafeArea()
                VStack {
                    Image(book.coverImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 195)
                        .cornerRadius(10)
                        .clipped()
                        .padding(.top, 30)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Spacer()
                                Text(book.title)
                                    .font(.custom("DMSerifDisplay-Regular", size: 27))
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 1)
                                    .frame(minWidth: geometry.size.width, alignment: .center)
                            }
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            Text(book.author)
                                .font(.custom("Inter", size: 15))
                                .fontWeight(.medium)
                                .foregroundStyle(Color("Caption-Color"))
                                .frame(minWidth: geometry.size.width, alignment: .center)
                        }
                        
                        HStack {
                            Text("\(book.pages) pages")
                                .font(.custom("Inter", size: 13))
                                .fontWeight(.light)
                                .padding(10)
                                .glassEffect()
                            
                            Text(String(book.year))
                                .font(.custom("Inter", size: 13))
                                .fontWeight(.light)
                                .padding(10)
                                .glassEffect()
                        }
                        .padding(5)
                        
                        Text("\(Image(systemName: "books.vertical")) \(book.status ? "Available to borrow" : "Currently on loan")")
                            .font(.custom("Inter", size: 15))
                            .fontWeight(.medium)
                            .padding(10)
                            .foregroundStyle(book.status ? Color("Ok-Color") : Color("No-Color"))
                            .background(book.status ? Color("Ok-Bg") : Color("No-Bg"))
                            .cornerRadius(30)
                            .padding(.bottom)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color("Bg-Card"))
                                .frame(height: 200)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                                .padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text("About this book")
                                    .font(.custom("DMSerifDisplay-Regular", size: 23))
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.6)
                                ScrollView(.vertical, showsIndicators: false) {
                                    Text(book.about)
                                        .font(.custom("Inter", size: 15))
                                        .fontWeight(.regular)
                                }
                                .padding(.top, -10)
                            }
                            .frame(height: 160)
                            .padding(.horizontal)
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                    Button {
                        showAlert = true
                    } label : {
                        ZStack {
                            Rectangle()
                                .fill(book.status ?  Color("Ok-Color") : Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.1029961918)))
                                .cornerRadius(12)
                                .frame(height: 40)
                            Text(book.status ? "\(Image(systemName: "book")) Borrow this book" : "\(Image(systemName: "xmark.circle")) Still on loan")
                                .font(.custom("Inter", size: 15))
                                .fontWeight(.medium)
                                .foregroundStyle(book.status ? Color("WhiteButton") : Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        .padding(.bottom)
                    }
                    .disabled(!book.status)
                    .alert(isPresented: $showAlert) {
                        Alert (
                            title: Text("Borrow this book"),
                            message: Text("Are you sure to borrow this book?"),
                            primaryButton: .default(
                                Text("Yes"),
                                action: {
                                    if lendVM.checkCanBorrow(for: user, book: book) {
                                        lendVM.borrowBook(for: user, book: book, booksVM: bookVM)
                                        toastMessage = "You've successfully borrowed this book"
                                        showToast = true
                                    } else {
                                        toastMessage = "You've reached your borrowing limit"
                                        showToast = true
                                    }
                                }
                            ),
                            secondaryButton: .cancel(
                                Text("Cancel"),
                            )
                        )
                    }
                    .padding()
                }
            }
            .overlay(alignment: .top) {
                if showToast {
                    ToastCard(toastMessage: toastMessage, showToast: $showToast)
                }
            }
        }
    }
}

#Preview {
    BooksView(book: .constant(BooksViewModel().books[0]), user: .constant(UserViewModel().users[0]), lendVM: .constant(LendViewModel(userVM: UserViewModel())), bookVM: .constant(BooksViewModel()))
}
