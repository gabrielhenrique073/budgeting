import SwiftUI
import Foundation
import CoreData

struct Window: View {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
//    @Environment(\.managedObjectContext) private var managedObjectContext
//    
//    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<Category>
//    
//    @State private var isBillCreatorOpen = false
//    @State private var billTitle = ""
//    @State private var billCategory: Int = 0
//    @State private var billFlow: Int = 0
//    @State private var billInterval: Int = 1
//    @State private var billFrequency: Int = 0
//    @State private var billRecurrence: Int = 0
//    @State private var billAmount = ""
//    @State private var billDate = Date.now
//    
//    @State private var isBillEditorOpen = false

    var body: some View {
        TabView {
            SettingsView(context: context)
                .tabItem {
                   Label("Settings", systemImage: "gear")
               }
            
            
            
            
            
            
//            BillsManager()
//                .tabItem {
//                    Label("Bills", systemImage: "dollarsign")
//                }
            
            

            
            
            
            
//            // Bills
//            NavigationStack {
//                BillsManager()
//                    .navigationTitle("Bills")
//                    .navigationBarTitleDisplayMode(.large)
//                    .toolbar {
//                        ToolbarItem(
//                            placement: .topBarTrailing,
//                            content: {
//                                Button(
//                                    action: {
//                                        isBillCreatorOpen.toggle()
//                                    },
//                                    label: {
//                                        Image(systemName: "plus.circle.fill")
//                                    }
//                                )
//                            }
//                        )
//                    }
//                    .sheet(
//                        isPresented: $isBillCreatorOpen,
//                        content: {
//                            NavigationStack {
//                                Form {
//                                    Section(
//                                        header: Text("Basic Information"),
//                                        content: {
//                                            TextField("Title", text: $billTitle)
//                                            
//                                            Picker("Category", selection: $billCategory) {
//                                                ForEach(categories.indices, id: \.self) { index in
//                                                    Label (
//                                                        title: {
//                                                            Text(categories[index].name ?? "")
//                                                        },
//                                                        icon: {
//                                                            Text(categories[index].icon ?? "")
//                                                        }
//                                                    )
//                                                    .tag(index)
//                                                }
//                                            }
//                                            .pickerStyle(.navigationLink)
//
//                                            Picker("Flow", selection: $billFlow) {
//                                                Text(Flow.expense.label).tag(Flow.expense.rawValue)
//                                                Text(Flow.income.label).tag(Flow.income.rawValue)
//                                            }
//                                            .pickerStyle(.menu)
//
//                                            Stepper("Interval: \(billInterval)", value: $billInterval, in: 1...365, step: 1)
//
//                                            Picker("Frequency", selection: $billFrequency) {
//                                                Text(Frequency.daily.label).tag(Frequency.daily.rawValue)
//                                                Text(Frequency.weekly.label).tag(Frequency.weekly.rawValue)
//                                                Text(Frequency.monthly.label).tag(Frequency.monthly.rawValue)
//                                                Text(Frequency.quarterly.label).tag(Frequency.quarterly.rawValue)
//                                                Text(Frequency.annually.label).tag(Frequency.annually.rawValue)
//                                            }
//                                            .pickerStyle(.menu)
//
//                                            Picker("Recurrence", selection: $billRecurrence) {
//                                                Text(Recurrence.determined.label).tag(Recurrence.determined.rawValue)
//                                                Text(Recurrence.indeterminate.label).tag(Recurrence.indeterminate.rawValue)
//                                            }
//                                            .pickerStyle(.menu)
//
//                                            TextField("Amount", text: $billAmount)
//
//                                            DatePicker(
//                                                selection: $billDate,
//                                                in: Date.now...,
//                                                displayedComponents: .date,
//                                                label: {
//                                                    Text("Date")
//                                                }
//                                            )
//                                        }
//                                    )
//                                }
//                                .navigationTitle("New Bill")
//                                .navigationBarTitleDisplayMode(.inline)
//                                .toolbar {
//                                    ToolbarItem(
//                                        placement: .topBarLeading,
//                                        content: {
//                                            Button(
//                                                action: {
//                                                    isBillCreatorOpen.toggle()
//                                                },
//                                                label: {
//                                                    Text("Cancel")
//                                                }
//                                            )
//                                        }
//                                    )
//                                    ToolbarItem(
//                                        placement: .topBarTrailing,
//                                        content: {
//                                            Button(
//                                                action: {
//                                                    let bill = Bill(context: managedObjectContext)
//                                                    bill.id = UUID()
//                                                    bill.title = billTitle
//                                                    bill.creation = Date.now
//                                                    bill.amount = billAmount.toFloat ?? 0
//                                                    bill.category = categories[billCategory]
//                                                    bill.flow = Int32(billFlow)
//                                                    bill.frequency = Int32(billFrequency)
//                                                    bill.recurrence = Int32(billRecurrence)
//                                                    bill.interval = Int32(billInterval)
//                                                    
//                                                    do {
//                                                        try managedObjectContext.save()
//                                                    } catch {
//                                                        fatalError("Failed to create new bill")
//                                                    }
//                                                    
//                                                    isBillCreatorOpen.toggle()
//                                                },
//                                                label: {
//                                                    Text("Done")
//                                                }
//                                            )
//                                            .disabled(billTitle.isEmpty || billAmount.isEmpty)
//                                        }
//                                    )
//                                }
//                            }
//                        }
//                    )
//            }
        }
    }
}






//    

////            // Monitor
//////            Monitor()
//////            .tabItem {
//////                Label("Monitor", systemImage: "light.beacon.min.fill")
//////            }
////
