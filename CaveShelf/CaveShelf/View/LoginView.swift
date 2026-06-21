//
//  LoginView.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 12/06/26.
//

import SwiftUI

struct LoginView: View {
    @State var userVM = UserViewModel()
    @State var booksVM = BooksViewModel()
    @State var lendVM: LendViewModel
    @State var loggedInUser: UsersModel?
    
    init() {
        let userVM = UserViewModel()
        _userVM = State(initialValue: userVM)
        _booksVM = State(initialValue: BooksViewModel())
        _lendVM = State(initialValue: LendViewModel(userVM: userVM))
    }
    
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showInvalid = false
    
    var body: some View {
        if loggedInUser != nil {
            MainTabView(userVM: $userVM, booksVM: $booksVM, lendVM: $lendVM, loggedInUser: $loggedInUser)
        } else {
            NavigationStack {
                ZStack {
                    Color("Bg-Color").ignoresSafeArea()
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .cornerRadius(30)
                        Text("Cave Shelf")
                            .font(.custom("DMSerifDisplay-Regular", size: 29))
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                        Text("Shelving Stories, Sharing Knowledge.")
                            .font(.custom("Inter", size: 13))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("Caption-Color"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.bottom, 30)
                        
                        VStack (alignment: .leading){
                            Text("Username")
                                .font(.custom("Inter", size: 17))
                                .fontWeight(.medium)
                            TextField("yourname", text: $username)
                                .font(.custom("Inter", size: 15))
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .padding(.horizontal, 15)
                                .padding(.vertical, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("Bg-Card"))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 0.5)
                                )
                        }
                        .padding(.bottom)
                        
                        VStack (alignment: .leading) {
                            Text("Password")
                                .font(.custom("Inter", size: 17))
                                .fontWeight(.medium)
                            HStack {
                                if showPassword {
                                    TextField("••••••••••", text: $password)
                                        .font(.custom("Inter", size: 15))
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                } else {
                                    SecureField("••••••••••", text: $password)
                                        .font(.custom("Inter", size: 15))
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                }
                                
                                Button {
                                    showPassword.toggle()
                                } label: {
                                    Image(systemName: showPassword ? "eye.slash" : "eye")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("Bg-Card"))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                        }
                        .padding(.bottom, 40)
                        
                        Button {
                            if let user = userVM.users.first(where: {
                                $0.username == username &&
                                $0.password == password
                            }) {
                                loggedInUser = user
                                username = ""
                                password = ""
                            } else {
                                showInvalid = true
                            }
                        } label: {
                            Text("Sign In")
                                .font(.custom("Inter", size: 19))
                                .fontWeight(.bold)
                                .foregroundStyle(Color("WhiteButton"))
                                .lineLimit(1)
                                .minimumScaleFactor(0.4)
                                .padding(.horizontal, 150)
                                .padding(.vertical)
                                .background(Color("Ok-Color"))
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Don't have an account?")
                                .font(.custom("Inter", size: 15))
                                .fontWeight(.regular)
                                .foregroundStyle(Color("Caption-Color"))
                                .lineLimit(1)
                                .minimumScaleFactor(0.4)
                            NavigationLink {
                                SignUpView(userVM: $userVM, booksVM: $booksVM, lendVM: $lendVM, loggedInUser: $loggedInUser)
                            } label: {
                                Text("Sign Up")
                                    .font(.custom("Inter", size: 15))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color("Golden-Color"))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .navigationBarBackButtonHidden(true)
                }
                .overlay(alignment: .top) {
                    if showInvalid {
                        InvalidCard(invalidMessage: "Invalid Username or Password", showInvalid: $showInvalid)
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
