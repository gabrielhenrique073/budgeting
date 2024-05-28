//import SwiftUI
//import SwiftData
//import Foundation
//import Charts
//
//struct Forecasting: View {
//    
//    // Argument
//    var from: Date
//    var to: Date
//    
//    // Environment
//    @Environment(\.modelContext) private var modelContext
//    
//    // Computed Properties
//    var balance: Float {
//        var value: Float = 0;
//        
//        for bill in bills {
////            if bill.flow == .income {
////                value += bill.amount
////            }
////            else {
////                value -= bill.amount
////            }
//        }
//        
//        return value
//    }
//    var bills: [Bill] {
//        return [
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .income, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 1000, date: Date.from(date: "2024-01-01")!),
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .expense, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 750, date: Date.from(date: "2024-01-01")!),
////            
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .income, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 1000, date: Date.from(date: "2024-01-07")!),
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .expense, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 1000, date: Date.from(date: "2024-01-07")!),
////            
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .income, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 669, date: Date.from(date: "2024-01-14")!),
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .expense, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 1000, date: Date.from(date: "2024-01-14")!),
////            
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .income, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 669, date: Date.from(date: "2024-01-22")!),
////            Bill(title: "", category: Category(name: "", icon: ""), flow: .expense, interval: 1, frequency: .weekly, recurrence: .indeterminate, amount: 20, date: Date.from(date: "2024-01-22")!),
//        ]
//    }
//    
//    var body: some View {
//        
//        Text(balance.toCurrency)
//            .foregroundColor(balance > 0 ? .green : .red)
//            .font(.title2)
//            .bold()
//        Text("This is how much you have left after paying all your debts within the next 3 months")
//        
////        ForecastingChart(
////            bills: bills
////        )
//        
//        Text("Red symbolize your expendings and green your incomes, each bar represent a week starting from now to 3 months ahead")
//            .font(.footnote)
//    }
//}
