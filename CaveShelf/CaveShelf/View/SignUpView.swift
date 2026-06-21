//
//  SignUpView.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 17/06/26.
//

import SwiftUI

struct SignUpView: View {
    @Binding var userVM: UserViewModel
    @Binding var booksVM: BooksViewModel
    @Binding var lendVM: LendViewModel
    @Binding var loggedInUser: UsersModel?
    @Environment(\.dismiss) private var dismiss

    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var errorMessage = ""
    
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
                        
                        ScrollView(.vertical, showsIndicators: false) {
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
                            
                            VStack (alignment: .leading){
                                Text("First Name")
                                    .font(.custom("Inter", size: 17))
                                    .fontWeight(.medium)
                                TextField("first name", text: $firstName)
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
                            
                            VStack (alignment: .leading){
                                Text("Last Name")
                                    .font(.custom("Inter", size: 17))
                                    .fontWeight(.medium)
                                TextField("last name", text: $lastName)
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
                        }
                        .frame(maxHeight: 350)
                        
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundStyle(Color("No-Color"))
                                .font(.caption)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        }
                        
                        Button {
                            let newUser = UsersModel(
                                username: username,
                                firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized,
                                lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines).capitalized,
                                password: password,
                                maxLoan: 3
                            )
                            
                            let success = userVM.createUser(newUser)
                            
                            if success {
                                dismiss()
                            } else {
                                if username == "" {
                                    errorMessage = "Username cannot be empty."
                                    return
                                } else if firstName == "" {
                                    errorMessage = "First name cannot be empty."
                                } else if lastName == "" {
                                    errorMessage = "Last name cannot be empty."
                                } else if password == "" || password.count <= 8 {
                                    errorMessage = "Password must contain at least 8 characters."
                                } else {
                                    errorMessage = "Username already exists."
                                }
                            }
                        } label: {
                            Text("Create Account")
                                .font(.custom("Inter", size: 19))
                                .fontWeight(.bold)
                                .foregroundStyle(Color("WhiteButton"))
                                .padding(.horizontal, 90)
                                .padding(.vertical)
                                .background(
                                    Color("Ok-Color")
                                )
                                .cornerRadius(10)
                                .lineLimit(1)
                                .minimumScaleFactor(0.4)
                        }
                        .padding(.bottom)
                        
                        HStack {
                            Text("Already have an account?")
                                .font(.custom("Inter", size: 15))
                                .fontWeight(.regular)
                                .foregroundStyle(Color("Caption-Color"))
                            Button {
                                dismiss()
                            } label: {
                                Text("Sign In")
                                    .font(.custom("Inter", size: 15))
                                    .fontWeight(.black)
                                    .foregroundStyle(Color("Golden-Color"))
                            }
                        }
                    }
                    .padding(.horizontal)
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    SignUpView(userVM: .constant(UserViewModel()), booksVM: .constant(BooksViewModel()), lendVM: .constant(LendViewModel(userVM: UserViewModel())), loggedInUser: .constant(UserViewModel().users[1]))
}
