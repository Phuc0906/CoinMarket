//
//  CoinRowView.swift
//  CoinMarket
//
//  Created by Zoey on 14/09/2023.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingCol: Bool
    var body: some View {
        HStack(spacing: 0) {
            leftCol
            Spacer()
            if(showHoldingCol) {
                centerCol
            }
            rightCol
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingCol: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingCol: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

extension CoinRowView {
    private var leftCol: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .foregroundColor(Color.theme.secondaryText)
                .font(.caption)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerCol: some View {
        VStack (alignment: .trailing){
            Text("\(coin.currentHoldingValue.asCurrencyWith2Decimals())")
                .bold()
                .foregroundColor(Color.theme.accent)
            Text("\(coin.currentHoldings?.asNumberString() ?? "")")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
    }
    
    private var rightCol: some View {
        VStack (alignment: .trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundColor(Color.theme.accent)
            Text("\(coin.priceChangePercentage24H?.asPercentString() ?? "")")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
