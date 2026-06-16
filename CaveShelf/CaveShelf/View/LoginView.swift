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
    @State var lendVM = LendViewModel(userVM: UserViewModel())
    @State var loggedInUser: UsersModel?
    
    @State private var username = ""
    @State private var password = ""
    @State private var showPassword = false
    
    var body: some View {
        if Binding($loggedInUser) != nil {
            MainTabView(userVM: $userVM, booksVM: $booksVM, lendVM: $lendVM, loggedInUser: $loggedInUser)
        } else {
            NavigationStack {
                ZStack {
                    Color(#colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.9333333333, alpha: 1)).ignoresSafeArea()
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .cornerRadius(30)
                        
                        Text("Cave Shelf")
                            .font(.custom("DMSerifDisplay-Regular", size: 29))
                            .fontWeight(.bold)
                        Text("Shelving Stories, Sharing Knowledge.")
                            .font(.custom("Inter", size: 13))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
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
                                        .fill(Color.white)
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
                                    .fill(Color.white)
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
                            }
                        } label: {
                            Text("Sign In")
                                .font(.custom("Inter", size: 19))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(#colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.9333333333, alpha: 1)))
                                .padding(.horizontal, 150)
                                .padding(.vertical)
                                .background(Color(#colorLiteral(red: 0.1764705882, green: 0.3137254902, blue: 0.0862745098, alpha: 1)))
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Don't have an account?")
                                .font(.custom("Inter", size: 15))
                                .fontWeight(.regular)
                                .foregroundStyle(Color(#colorLiteral(red: 0.1098039216, green: 0.07843137255, blue: 0.06274509804, alpha: 0.6)))
                            Button {
                                
                            } label: {
                                Text("Sign Up")
                                    .font(.custom("Inter", size: 15))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color(#colorLiteral(red: 0.768627451, green: 0.5254901961, blue: 0.168627451, alpha: 1)))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
