//
//  PieChartView.swift
//  CoinMarket
//
//  Created by Zoey on 18/09/2023.
//

import SwiftUI

struct PieChartCell: Shape {
    let startAngle: Angle
    let endAngle: Angle
    func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
        let radii = min(center.x, center.y)
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
    }
}

struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let name: String
    let amount: Double
}

final class ChartDataModel: ObservableObject {
    var chartCellModel: [ChartCellModel]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
    
    
    init(dataModel: [ChartCellModel]) {
        chartCellModel = dataModel
    }
    
    var totalValue: Double {
        var total: Double = 0
        chartCellModel.forEach { data in
            total += data.amount
        }
        return total
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        print(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}

let sample = [
    ChartCellModel(color: Color.red, name: "Bitcoin", amount: 5),
    ChartCellModel(color: Color.purple, name: "Etherum", amount: 3)
]

struct PieChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
        ZStack {
            ForEach(dataModel.chartCellModel) { dataSet in
                PieChartCell(startAngle: self.dataModel.angle(for: dataSet.amount), endAngle: self.dataModel.startingAngle)
                    .foregroundColor(dataSet.color)
                    .onTapGesture {
                        withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
            }
        }
    }
}

struct PieChartView: View {
    @State var selectedPie: String = ""
    @State var selectedDonut: String = ""
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    PieChart(dataModel: ChartDataModel.init(dataModel: sample), onTap: {
                        dataModel in
                        if let dataModel = dataModel {
                            self.selectedPie = "Selcted Coin \(dataModel.name)"
                        } else {
                            self.selectedPie = ""
                        }
                    })
                    .frame(width: 150, height: 150, alignment: .center)
                    .padding()
                }
                Text("\(selectedPie)")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack {
                    ForEach(sample) {data in
                        Spacer()
                        VStack {
                            Circle()
                                .frame(maxWidth: 30, maxHeight: 30)
                                .foregroundColor(data.color)
                            Text(data.name).font(.footnote)
                            
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView()
    }
}
