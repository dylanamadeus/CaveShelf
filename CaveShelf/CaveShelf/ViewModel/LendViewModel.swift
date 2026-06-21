//
//  LendViewModel.swift
//  CaveShelf
//
//  Created by Dylan Amadeus on 11/06/26.
//

import Foundation
import Observation

@Observable
final class LendViewModel {
    var lends: [LendModel]
    
    init(userVM: UserViewModel) {
        self.lends = []
        loadLends(userVM: userVM)
    }
    
    func userLoan(for user: UsersModel) -> Int {
        lends.filter {
            $0.userID == user.id && !$0.isReturn
        }.count
    }
    
    func overdueLoan(for user: UsersModel) -> Int {
        lends.filter {
            $0.userID == user.id && !$0.isReturn && $0.dueDate < Date()
        }.count
    }
    
    func totalRead(for user: UsersModel) -> Int {
        lends.filter {
            $0.userID == user.id && $0.isReturn
        }.count
    }
    
    func checkCanBorrow(for user: UsersModel, book: BooksModel) -> Bool {
        userLoan(for: user) < user.maxLoan && book.status
    }
    
    func borrowBook(for user: UsersModel, book: BooksModel, booksVM: BooksViewModel) {
        if let index = booksVM.books.firstIndex(where: { $0.id == book.id }) {
            booksVM.books[index].status = false
        }
//        book.status = false
        booksVM.saveBooks()
        let borrowDate = Date()
        let dueDate = Calendar.current.date(
            byAdding: .day,
            value: 14,
            to: borrowDate
        )!
        
        lends.append(
            LendModel(
                userID: user.id,
                bookID: book.id,
                borrowDate: borrowDate,
                dueDate: dueDate,
                returnDate: nil,
                isReturn: false
            )
        )
        
        saveLends()
    }
    
    func returnBook(lendID: UUID, book: BooksModel, user: inout UsersModel, userVM: UserViewModel, booksVM: BooksViewModel) {
        if let lendIndex = lends.firstIndex(where: { $0.id == lendID }) {
            let today = Date()

            lends[lendIndex].isReturn = true
            lends[lendIndex].returnDate = today
//            book.status = true
            if let bookIndex = booksVM.books.firstIndex(where: { $0.id == book.id }) {
                booksVM.books[bookIndex].status = true
            }
            booksVM.saveBooks()

            print("RETURN CALLED for lend \(lendID)")
            print("Before: \(user.maxLoan)")

            if today > lends[lendIndex].dueDate {
                userVM.decreaseMaxLoan(for: &user)
            }
            saveLends()
            print("Return book successfully")
            print("\(user.id)")
            print("Max Loan for user \(user.firstName): \(user.maxLoan)")
        }
    }
    
    func saveLends() {
        do {
            let encoded = try JSONEncoder().encode(lends)
            UserDefaults.standard.set(encoded, forKey: "lends")
            print("Lends Saved")
        } catch {
            print("Failed to save lends: \(error)")
        }
    }
    
    func loadLends(userVM: UserViewModel) {
        if let data = UserDefaults.standard.data(forKey: "lends") {
            do {
                let decoded = try JSONDecoder().decode([LendModel].self, from: data)
                lends = decoded
            } catch {
                print("Failed to load lends: \(error)")
            }
        } else {
            lends = [
                LendModel(
                    userID: userVM.users[0].id,
                    bookID: BooksViewModel().books[28].id,
                    borrowDate: Calendar.current.date(
                        from: DateComponents(year: 2026, month: 6, day: 5)
                    )!,
                    dueDate: Calendar.current.date(
                        byAdding: .day,
                        value: 14,
                        to: Calendar.current.date(
                            from: DateComponents(year: 2026, month: 6, day: 5)
                        )!
                    )!,
                    returnDate: nil,
                    isReturn: false
                ),
                LendModel(
                    userID: userVM.users[0].id,
                    bookID: BooksViewModel().books[29].id,
                    borrowDate: Calendar.current.date(
                        from: DateComponents(year: 2026, month: 6, day: 19)
                    )!,
                    dueDate: Calendar.current.date(
                        byAdding: .day,
                        value: 14,
                        to: Calendar.current.date(
                            from: DateComponents(year: 2026, month: 6, day: 19)
                        )!
                    )!,
                    returnDate: nil,
                    isReturn: false
                ),
                LendModel(
                    userID: userVM.users[1].id,
                    bookID: BooksViewModel().books[28].id,
                    borrowDate: Calendar.current.date(
                        from: DateComponents(year: 2026, month: 3, day: 23)
                    )!,
                    dueDate: Calendar.current.date(
                        byAdding: .day,
                        value: 14,
                        to: Calendar.current.date(
                            from: DateComponents(year: 2026, month: 3, day: 23)
                        )!
                    )!,
                    returnDate: Calendar.current.date(
                        from: DateComponents(year: 2026, month: 4, day: 1)
                    )!,
                    isReturn: true
                )
            ]
            saveLends()
        }
    }
}
