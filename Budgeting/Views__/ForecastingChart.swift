import SwiftUI
import SwiftData
import Foundation
import Charts

struct ForecastingChart: View {
    
    // Bindings
//    var bills: [Bill]
    
    var body: some View {
        Chart {
//            ForEach(bills) { bill in
//                BarMark(
//                    x: .value("Week", bill.date, unit: .weekOfYear),
//                    y: .value("Amount", bill.amount)
//                )
//                .position(by: .value("Flow", bill.date, unit: .weekOfYear))
//                .foregroundStyle(by: .value("Flow", bill.flow.rawValue))
//           }
        }
        .padding(.vertical)
        .chartForegroundStyleScale(
            [
                Flow.income.rawValue: Color.green,
                Flow.expense.rawValue: Color.red
            ]
        )
    }
}
