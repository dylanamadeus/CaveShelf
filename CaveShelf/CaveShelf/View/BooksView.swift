//
//  BooksView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import SwiftUI

struct BooksView: View {
    @Binding var book: BooksModel
    let user: UsersModel
    let lendVM: LendViewModel
    
    @State private var showAlert = false
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack (alignment: .top){
            Color(#colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.9333333333, alpha: 1)).ignoresSafeArea()
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
                
                Text(book.title)
                    .font(.custom("DMSerifDisplay-Regular", size: 27))
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                
                Text(book.author)
                    .font(.custom("Inter", size: 15))
                    .fontWeight(.medium)
                    .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                
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
                    .foregroundStyle(book.status ? Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)) : Color(#colorLiteral(red: 0.768627451, green: 0.2745098039, blue: 0.168627451, alpha: 1)))
                    .background(book.status ? Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)) : Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 0.2)))
                    .cornerRadius(30)
                    .padding(.bottom)
                
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 1, green: 0.9921568627, blue: 0.9764705882, alpha: 1)))
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
                Spacer()
                Button {
                    showAlert = true
                } label : {
                    ZStack {
                        Rectangle()
                            .fill(book.status ?  Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)) : Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.1029961918)))
                            .cornerRadius(12)
                            .frame(height: 40)
                        Text(book.status ? "\(Image(systemName: "book")) Borrow this book" : "\(Image(systemName: "xmark.circle")) Still on loan")
                            .font(.custom("Inter", size: 15))
                            .fontWeight(.medium)
                            .foregroundStyle(book.status ? Color.white : Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
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
                                let success = lendVM.borrowBook(for: user, book: &book)
                                
                                if success {
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

#Preview {
    BooksView(book: .constant(BooksViewModel().books[0]), user: UserViewModel().users[0], lendVM: LendViewModel(userVM: UserViewModel()))
}
