//
//  DiscoverView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 10/06/26.
//

import SwiftUI

struct DiscoverView: View {
    @Binding var path: NavigationPath
//    let user: UsersModel
    @Binding var user: UsersModel
    @Binding var lendVM: LendViewModel
    @Binding var booksVM: BooksViewModel
    @State private var searchText = ""
    
    private var filteredBooks: [BooksModel] {
        guard !searchText.isEmpty else {
            return booksVM.books
        }
        
        return booksVM.books.filter { book in
            book.title.localizedCaseInsensitiveContains(searchText) ||
            book.author.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        ZStack {
            Color("Bg-Color").ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Discover")
                            .font(.custom("DMSerifDisplay-Regular", size: 29))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text("\(filteredBooks.count) " + (filteredBooks.count == 1 ? "book found" : "books found"))
                        .font(.custom("Inter", size: 15))
                        .fontWeight(.medium)
                        .foregroundStyle(Color("Caption-Color"))
                        .padding(.top, 5)
                    
                    ForEach(filteredBooks) { book in
                        NavigationLink(value: book) {
                            BooksCard(book: book)
                                .padding(.bottom, 5)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
            }
            .navigationDestination(for: BooksModel.self) { book in
                if let index = booksVM.books.firstIndex(where: {
                    $0.id == book.id
                }) {
                    BooksView(
                        book: $booksVM.books[index],
                        user: $user,
                        lendVM: $lendVM,
                        bookVM: $booksVM
                    )
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search books, authors...")
    }
}

#Preview {
    DiscoverView(path: .constant(NavigationPath()), user: .constant(UserViewModel().users[0]), lendVM: .constant(LendViewModel(userVM: UserViewModel())), booksVM: .constant(BooksViewModel()))
}
