//
//  InfoView.swift
//  CoinMarket
//
//  Created by Zoey on 21/09/2023.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) private var presentationMode
    let coingeckoURL = URL(string: "https://www.coingecko.com/en/api")!
    var body: some View {
        List {
            Section("Crypto Tracker") {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 4)
                        .cornerRadius(radius: 20, corner: .allCorners)
                    Text("This app was made by NOPLAGIARISM team. It uses MVVM Architecture, Firebase and API from CoinGecko")
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                }
                .padding(.vertical)
            }
            
            Section("Coingecko") {
                VStack(alignment: .leading) {
                    Image("coingecko")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .cornerRadius(radius: 20, corner: .allCorners)
                    Text("This app's cryptocurrency data is obtained via a free api provided by COINGECKO. Prices could be a little bit delayed.")
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                }
                .padding(.vertical)
                Link("Visit COINGECKO", destination: coingeckoURL)
            }
            
            Section("Application") {
                Text("Terms of servic")
                Text("Privacy Policy")
                Text("Company Website")
                Text("Learn More")
            }
        }
        .listStyle(GroupedListStyle())
        .overlay (
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(20)
            }),
            alignment: .topTrailing
        )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
