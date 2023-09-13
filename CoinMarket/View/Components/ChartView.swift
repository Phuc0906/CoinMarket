//
//  ChartView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 13/09/2023.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    @State private var percentage: CGFloat = 0
    
    init(coin: Coin) {
        data = coin.sparkline_in_7d.price
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .green : .red
    }
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                chartView
                    .frame(height: geometry.size.height)
                    .background(chartBackground)
                    .overlay(
                        VStack {
                            Text("\(String(format: "%.2f", maxY))")
                            Spacer()
                            let avr = (maxY - minY) / 2
                            Text("\(String(format: "%.2f", avr))")
                            Spacer()
                            Text("\(String(format: "%.2f", minY))")
                        }
                        , alignment: .leading
                    )
            }.font(.caption)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.linear(duration: 1)) {
                        percentage = 1.0
                    }
                }
            }
        }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}


extension ChartView  {
    private var chartView: some View {
        GeometryReader {geometry in
            HStack {
                Path {path in
                    for index in data.indices {
                        let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                        
                        let yAxis = maxY - minY
                        
                        let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
                .trim(from: 0, to: percentage)
                .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            }
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
}
