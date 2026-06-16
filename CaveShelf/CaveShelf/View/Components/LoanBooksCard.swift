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
    let lend: LendModel
    let lendVM: LendViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(#colorLiteral(red: 1, green: 0.9921568627, blue: 0.9764705882, alpha: 1)))
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
                        Text(book.title)
                            .font(.custom("Inter", size: 19))
                            .fontWeight(.bold)
                        Text(book.author)
                            .font(.custom("Inter", size: 15))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                        
                        Text("\(Image(systemName: "calendar")) Due \(lend.dueDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.custom("Inter", size: 13))
                            .fontWeight(.medium)
                            .foregroundStyle(lend.dueDate >= Date() ? Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)) : Color(#colorLiteral(red: 0.768627451, green: 0.2745098039, blue: 0.168627451, alpha: 1)))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(lend.dueDate >= Date() ? Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)) : Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 0.2)))
                            .cornerRadius(30)
                            .padding(.top)
                    }
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                
                Button {
                    lendVM.returnBook(
                        lendID: lend.id,
                        book: &book,
                        user: &user)
                } label: {
                    Text("\(Image(systemName: "checkmark.circle.dotted")) Return")
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.medium)
                        .foregroundStyle(Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)))
                        .padding(.horizontal, 120)
                        .padding(.vertical, 10)
                        .glassEffect()
                }
                .buttonStyle(.plain)
                .padding(.top, 10)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
    }
}

#Preview {
    LoanBooksCard(
        user: .constant(UserViewModel().users[0]),
        book: .constant(BooksViewModel().books[0]),
        lend: LendViewModel(userVM: UserViewModel()).lends[2],
        lendVM: LendViewModel(userVM: UserViewModel()))
    
//    LoanBooksCard(
//        user: $user,
//        book: $booksVM.books[index],
//        lend: lend,
//        lendVM: lendVM
//    )

}
