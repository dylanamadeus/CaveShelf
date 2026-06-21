//
//  SplashScreen.swift
//  Cave Shelf
//
//  Created by Dylan Amadeus on 21/06/26.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color("Bg-Color").ignoresSafeArea()
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .cornerRadius(20)
                Text("Cave Shelf")
                    .font(.custom("DMSerifDisplay-Regular", size: 33))
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
            }
        }
    }
}

#Preview {
    SplashScreen()
}
