//
//  ToastCard.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 16/06/26.
//

import SwiftUI

struct ToastCard: View {
    let toastMessage: String
    @Binding var showToast: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "book.fill")
            
            Text(toastMessage)
                .font(.custom("Inter", size: 14))
                .fontWeight(.medium)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.top, 50)
        .transition(
            .move(edge: .top)
            .combined(with: .opacity)
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showToast = false
                }
            }
        }
    }
}

#Preview {
    ToastCard(toastMessage: "Apa kek", showToast: .constant(true))
}
