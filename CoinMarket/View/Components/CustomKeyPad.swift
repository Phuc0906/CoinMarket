//
//  CustomKeyPad.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 15/09/2023.
//

import SwiftUI

struct CustomKeyPad: View {
    @Binding var input: String
    
    let data = [
        type(id: 0, rows: [Row(id: 0, value: "1"), Row(id: 1, value: "2"), Row(id: 2, value: "3")]),
        type(id: 1, rows: [Row(id: 0, value: "4"), Row(id: 1, value: "5"), Row(id: 2, value: "6")]),
        type(id: 2, rows: [Row(id: 0, value: "7"), Row(id: 1, value: "8"), Row(id: 2, value: "9")]),
        type(id: 3, rows: [Row(id: 0, value: "."), Row(id: 1, value: "0"), Row(id: 2, value: "delete.left.fill")])
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(data, id: \.id) {rows in
                HStack(spacing: self.getSpacing()){
                    ForEach(rows.rows, id: \.id) {value in
                        Button {
                            if value.value == "delete.left.fill" {
                                if !input.isEmpty {
                                    input = String(input.dropLast())
                                }else {
                                    
                                }
                                
                            }else {
                                if value.value == "." {
                                    if !input.contains(".") {
                                        input += "."
                                    }
                                }else {
                                    input.append("\(value.value)")
                                }
                            }
                        } label: {
                            if value.value == "delete.left.fill" {
                                Image(systemName: value.value).font(.body).padding(.vertical)
                            }else {
                                Text(value.value)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .padding(.vertical)
                                    
                            }
                        }

                    }
                }
            }
        }
        
        
    }
    func getSpacing() -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
}

struct type: Identifiable {
    var id: Int
    var rows: [Row]
}

struct Row: Identifiable {
    var id: Int
    var value: String
}

