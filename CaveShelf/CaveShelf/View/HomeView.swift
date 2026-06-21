//
//  HomeView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 09/06/26.
//

import SwiftUI

struct HomeView: View {
    @Binding var user: UsersModel
    @Binding var lendVM: LendViewModel
    @Binding var booksVM: BooksViewModel
    var onSeeAll: () -> Void = {}
    var onProfile: () -> Void = {}
    var onSignOut: () -> Void = {}
    
    @State private var path = NavigationPath()
    @State private var selectedBook: BooksModel?
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("Bg-Color").ignoresSafeArea()
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(
                                    Calendar.current.component(.hour, from: Date()) < 12
                                    ? "Good Morning,"
                                    : Calendar.current.component(.hour, from: Date()) < 17
                                    ? "Good Afternoon,"
                                    : "Good Evening,"
                                )
                                    .font(.custom("Inter", size: 15))
                                    .foregroundStyle(Color("Caption-Color"))
                                    .fontWeight(.medium)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.5)
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.custom("DMSerifDisplay-Regular", size: 29))
                                    .fontWeight(.bold)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.5)
                            }
                            Spacer()
                            
                            Menu {
                                Button {
                                    onProfile()
                                } label: {
                                    Label("Profile", systemImage: "person.crop.circle")
                                }
                                
                                Button (role: .destructive) {
                                    onSignOut()
                                } label: {
                                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 50)
                                        .glassEffect()
                                    Text("\(user.firstName.prefix(1))\(user.lastName.prefix(1))")
                                        .font(.custom("DMSerifDisplay-Regular", size: 17))
                                        .fontWeight(.bold)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.vertical)
                        
                        let randomIndex = Int.random(in: 0..<booksVM.books.count)
                        
                        NavigationLink(value: booksVM.books[randomIndex]) {
                            RecommendationCard(book: booksVM.books[randomIndex])
                        }
                        
                        HStack {
                            Text("Available Now")
                                .font(.custom("DMSerifDisplay-Regular", size: 23))
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                            
                            Spacer()
                            
                            Button {
                                onSeeAll()
                            } label: {
                                Text("See all")
                                    .font(.custom("Inter", size: 17))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color("Golden-Color"))
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color("Golden-Color"))
                                    .font(.system(size: 13))
                            }
                        }
                        .padding(.top)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(booksVM.books.filter{$0.status}) { book in
                                    NavigationLink(value: book) {
                                        AvailableBooksCard(book: book)
                                            .padding(.trailing, 5)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                        HStack {
                            Text("New Arrivals")
                                .font(.custom("DMSerifDisplay-Regular", size: 23))
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                            Spacer()
                        }
                        .padding(.top)
                        
                        ForEach(booksVM.books.prefix(3)) { book in
                            NavigationLink(value: book) {
                                BooksCard(book: book)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
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
    }
}

#Preview {
    HomeView(user: .constant(UserViewModel().users[0]), lendVM: .constant(LendViewModel(userVM: UserViewModel())), booksVM: .constant(BooksViewModel()))
}
