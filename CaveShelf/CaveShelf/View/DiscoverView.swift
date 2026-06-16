//
//  DiscoverView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 10/06/26.
//

import SwiftUI

struct DiscoverView: View {
    @Binding var path: NavigationPath
    let user: UsersModel
    let lendVM: LendViewModel
    @State var booksVM: BooksViewModel
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
            Color(#colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.9333333333, alpha: 1)).ignoresSafeArea()
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
                        .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
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
                        user: user,
                        lendVM: lendVM
                    )
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search books, authors...")
    }
}

#Preview {
    DiscoverView(path: .constant(NavigationPath()), user: UserViewModel().users[0], lendVM: LendViewModel(userVM: UserViewModel()), booksVM: BooksViewModel())
}
