//
//  InvalidCard.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 17/06/26.
//

import SwiftUI

struct InvalidCard: View {
    let invalidMessage: String
    @Binding var showInvalid: Bool
    
    var body: some View {
        HStack {
            Text("\(Image(systemName: "exclamationmark.circle"))")
                .font(.custom("Inter", size: 17))
                .foregroundStyle(Color.red)
            
            Text(invalidMessage)
                .font(.custom("Inter", size: 17))
                .fontWeight(.medium)
                .foregroundStyle(Color("No-Color"))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color("No-Bg"))
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.top)
        .transition(
            .move(edge: .top)
            .combined(with: .opacity)
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showInvalid = false
                }
            }
        }
    }
}

#Preview {
    InvalidCard(invalidMessage: "apa kek", showInvalid: .constant(true))
}
