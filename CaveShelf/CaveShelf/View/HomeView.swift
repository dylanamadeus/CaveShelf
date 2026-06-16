//
//  HomeView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 09/06/26.
//

import SwiftUI

struct HomeView: View {
    let user: UsersModel
    let lendVM: LendViewModel
    @State var booksVM: BooksViewModel
    var onSeeAll: () -> Void = {}
    var onProfile: () -> Void = {}
    var onSignOut: () -> Void = {}
    
    @State private var path = NavigationPath()
    @State private var selectedBook: BooksModel?
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(#colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.9333333333, alpha: 1)).ignoresSafeArea()
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
                                    .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.8)))
                                    .fontWeight(.medium)
                                Text("\(user.firstName) \(user.lastName)")
                                    .font(.custom("DMSerifDisplay-Regular", size: 29))
                                    .fontWeight(.bold)
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
                            
                            Spacer()
                            
                            Button {
                                onSeeAll()
                            } label: {
                                Text("See all")
                                    .font(.custom("Inter", size: 17))
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
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
                        user: user,
                        lendVM: lendVM
                    )
                }
            }
        }
    }
}

#Preview {
    HomeView(user: UserViewModel().users[0], lendVM: LendViewModel(userVM: UserViewModel()), booksVM: BooksViewModel())
}
