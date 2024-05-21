import SwiftUI
import Charts
import SwiftData
import Foundation

struct Monitor: View {
    
    // Environment
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    
    static var now: Date {
        Date.now
    }
    static var yesterday: Date {
        Calendar.current.date(byAdding: .day, value: -2, to: now)!
    }
    static var in7Days: Date {
        Calendar.current.date(byAdding: .day, value: 7, to: now)!
    }
    static var inQuarter: Date {
        Calendar.current.date(byAdding: .month, value: 3, to: now)!
    }
    
    @Query(
        filter: #Predicate { item in
            return item.dueAt >= yesterday && item.dueAt <= in7Days
        },
        sort: [
            SortDescriptor(\Bill.title)
        ]
    )
    var commingUpBills: [Bill]
    
    @Query(
        filter: #Predicate { item in
            return item.dueAt >= now && item.dueAt <= inQuarter
        },
        sort: [
            SortDescriptor(\Bill.title)
        ]
    )
    var forecastingBills: [Bill]
    
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
                                                    .foregroundColor(bill.isExpense ? .red : .green)
                                                
                                                // Due
                                                Text(bill.dueAt.description)
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
                    header: Text("Quarter Ahead"),
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
                                        
                                        Text("$280.00")
                                        .foregroundColor(.green)
                                        .font(.title)
                                        
                                        Text("You still have $280.00 left after paying your bills by the end the quarter")
                                        .font(.footnote)
                                        .fixedSize(horizontal: false, vertical: true)
                                    }
                                )
                                .padding(.vertical)
                                
                                Chart {
                                    ForEach(forecastingBills) { bill in
                                        BarMark(
                                            x: .value("Week", Calendar.current.component(.weekOfYear, from: bill.dueAt)),
                                            y: .value("Amount", bill.amount)
                                        )
                                        .foregroundStyle(by: .value("Type", bill.isExpense ? "Expense" : "Income"))
                                    }
                                }
                                .chartForegroundStyleScale(
                                    [
                                        "Income": Color.green,
                                        "Expense": Color.red
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
