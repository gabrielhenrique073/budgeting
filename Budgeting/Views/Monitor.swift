import SwiftUI
import Charts
import SwiftData
import Foundation

struct Monitor: View {
    
    // Environment
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    // Queries
    @Query(
        sort: [
            SortDescriptor(\Bill.title)
        ]
    )
    var bills: [Bill]
    
    // Computed
    var commingUpBills: [Bill] {
        return []
    }
    var billsForecasting: [Bill] {
        
        var forecast: [Bill] = []
        
        for bill in self.bills {
            
            if bill.recurrence == .indeterminate {
                let billStartDate = bill.date
                let billEndDate = Calendar.current.date(byAdding: .year, value: 1, to: Date.now)!
                var billCurrentDate = billStartDate
                
                while billCurrentDate <= billEndDate {
                    
                    forecast.append(
                        Bill(title: bill.title, category: bill.category, flow: bill.flow, interval: bill.interval, frequency: bill.frequency, recurrence: bill.recurrence, amount: bill.amount, date: billCurrentDate)
                    )
                    
                    if bill.frequency == .daily {
                        billCurrentDate = Calendar.current.date(byAdding: .day, value: 1 * bill.interval, to: billCurrentDate)!
                    } else if bill.frequency == .weekly {
                        billCurrentDate = Calendar.current.date(byAdding: .day, value: 7 * bill.interval, to: billCurrentDate)!
                    } else if bill.frequency == .monthly {
                        billCurrentDate = Calendar.current.date(byAdding: .month, value: 1 * bill.interval, to: billCurrentDate)!
                    } else if bill.frequency == .quarterly {
                        billCurrentDate = Calendar.current.date(byAdding: .month, value: 3 * bill.interval, to: billCurrentDate)!
                    } else if bill.frequency == .annually {
                        billCurrentDate = Calendar.current.date(byAdding: .year, value: 1 * bill.interval, to: billCurrentDate)!
                    } else {
                        billCurrentDate = billEndDate
                    }
                }
            }
        }
        
        return forecast
    }
    var forecastingBalance: Float {
        var balance: Float = 0
        
        for bill in billsForecasting {
            if bill.flow == .income {
                balance += bill.amount
            } else {
                balance -= bill.amount
            }
        }
        
        return Float(balance)
    }
    
    init() {
        UserDefaults.standard.register(
            defaults: [
                "isFirstLaunch": true
            ]
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Comming Up"),
                    footer: Text("See bills about to be due"),
                    content: {
                        ForEach(commingUpBills) { bill in
                            Label (
                                title: {
                                    HStack (alignment: .center) {
                                        VStack (
                                            alignment: .leading,
                                            content: {
                                                
                                                // Category Name
                                                Text(bill.category.name)
                                                
                                                // Title
                                                Text(bill.title)
                                                    .font(.caption)
                                            }
                                        )
                                        Spacer()
                                        VStack (
                                            alignment: .trailing,
                                            content: {
                                                
                                                // Amount
                                                Text(String(bill.amount))
                                                    .foregroundColor(bill.flow == .expense ? .red : .green)
                                                
                                                // Due
                                                Text(bill.date.description)
                                                    .font(.caption)
                                            }
                                        )
                                    }
                                },
                                icon: {
                                    
                                    // Category Icon
                                    Text(bill.category.icon)
                                }
                            )
                        }
                    }
                )
                
                Section (
                    header: Text("Year Ahead"),
                    footer: Text("See an overview about how the current is going so you can take actions ahead of time"),
                    content: {
                        VStack (
                            alignment: .leading,
                            content: {
                                
                                VStack (
                                    alignment: .leading,
                                    content: {
                                        Text("Balance")
                                        .font(.title)
                                        
                                        Text(forecastingBalance.toCurrency)
                                        .foregroundColor(.green)
                                        .font(.title)
                                        
                                        Text("You still have $280.00 left after paying your bills by the end the quarter")
                                        .font(.footnote)
                                        .fixedSize(horizontal: false, vertical: true)
                                    }
                                )
                                .padding(.vertical)
                                
                                Chart {
                                    ForEach(billsForecasting) { bill in
                                        BarMark(
                                            x: .value("Week", bill.date, unit: .weekOfYear),
                                            y: .value("Amount", bill.amount)
                                        )
                                        .position(by: .value("Flow", bill.flow))
                                        .foregroundStyle(by: .value("Flow", bill.flow))
                                    }
                                }
                                .chartForegroundStyleScale(
                                    [
                                        Flow.expense: Color.red,
                                        Flow.income: Color.green
                                    ]
                                )
                                
                                Text("By the end of the next quarter you still positive which indicates that even paying all the recurrent bills you informed you will not have any hard times making more money to pay some bill.")
                                    .padding(.vertical)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        )
                    }
                )
            }
            
            .navigationTitle("Monitor")
            .navigationBarTitleDisplayMode(.large)
            
            .sheet(
                isPresented: $isFirstLaunch,
                content: {
                    Welcome()
                        .interactiveDismissDisabled()
                }
            )
        }
    }
}
