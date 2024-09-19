//
//  ErrorBannerView.swift
//  BankNasrMovieApp
//
//  Created by Eslam ALi on 19/09/2024.
//

import SwiftUI

struct ErrorBannerView: View {
    let errorMessage: String

    var body: some View {
        HStack {
            Text(errorMessage)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .background(Color.red)
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding([.horizontal, .top])
    }
}


