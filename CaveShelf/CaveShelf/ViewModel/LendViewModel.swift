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
        self.lends = [
            LendModel(
                userID: userVM.users[0].id,
                bookID: BooksViewModel().books[2].id,
                borrowDate: Calendar.current.date(
                    from: DateComponents(year: 2026, month: 5, day: 10)
                )!,
                dueDate: Calendar.current.date(
                    byAdding: .day,
                    value: 14,
                    to: Calendar.current.date(
                        from: DateComponents(year: 2026, month: 5, day: 10)
                    )!
                )!,
                returnDate: nil,
                isReturn: false
            ),
            LendModel(
                userID: userVM.users[0].id,
                bookID: BooksViewModel().books[1].id,
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
                userID: userVM.users[1].id,
                bookID: BooksViewModel().books[4].id,
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
    
    func borrowBook(for user: UsersModel, book: inout BooksModel) -> Bool {
        if !checkCanBorrow(for: user, book: book) {
            return false
        } else {
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
            
            book.status = false
            
            return true
        }
    }
    
    func returnBook(lendID: UUID, book: inout BooksModel, user: inout UsersModel) {
        if let lendIndex = lends.firstIndex(where: {
            $0.id == lendID
        }) {
            lends[lendIndex].isReturn = true
            lends[lendIndex].returnDate = Date()
            
            book.status = true
            if (Date() > lends[lendIndex].dueDate) {
                user.maxLoan -= 1
            }
        }
    }
}
