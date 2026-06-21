//
//  MainTabView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

private enum MainTab {
    case home
    case discover
    case myBooks
    case profile
}

struct MainTabView: View {
    @Binding var userVM: UserViewModel
    @Binding var booksVM: BooksViewModel
    @Binding var lendVM: LendViewModel
    @Binding var loggedInUser: UsersModel?
    @State private var selectedTab: MainTab = .home
    @State private var discoverPath = NavigationPath()
    @State private var myBooksTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            if let user = loggedInUser {
                let userBinding = Binding(
                    get: { user },
                    set: { loggedInUser = $0 }
                )
                Tab("Home", systemImage: "house.fill", value: .home) {
                    HomeView(user: userBinding, lendVM: $lendVM, booksVM: $booksVM,
                     onSeeAll: {
                        discoverPath = NavigationPath()
                        selectedTab = .discover
                    }, onProfile:  {
                        discoverPath = NavigationPath()
                        selectedTab = .profile
                    }, onSignOut: {
                        loggedInUser = nil
                    })
                }
                Tab("My Books", systemImage: "books.vertical", value: .myBooks) {
                    MyBooksView(user: userBinding, userVM: $userVM, lendVM: $lendVM, booksVM: $booksVM, selectedTab: $myBooksTab)
                }
                Tab("Profile", systemImage: "person.crop.circle", value: .profile) {
                    ProfileView(user: userBinding, lendVM: lendVM, booksVM: $booksVM, onRead: {
                        myBooksTab = 1
                        discoverPath = NavigationPath()
                        selectedTab = .myBooks
                    }, onLoan: {
                        myBooksTab = 0
                        discoverPath = NavigationPath()
                        selectedTab = .myBooks
                    }, onSignOut: {
                        loggedInUser = nil
                    })
                }
                Tab("Search", systemImage: "magnifyingglass", value: .discover, role: .search) {
                    NavigationStack(path: $discoverPath) {
                        DiscoverView(path: $discoverPath, user: userBinding, lendVM: $lendVM, booksVM: $booksVM)
                            .padding(.top, -40)
                    }
                }
            }
        }
        .tint(Color("Ok-Color"))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let userVM = UserViewModel()
    MainTabView(
        userVM: .constant(userVM),
        booksVM: .constant(BooksViewModel()),
        lendVM: .constant(LendViewModel(userVM: userVM)),
        loggedInUser: .constant(userVM.users[0])
    )
}
