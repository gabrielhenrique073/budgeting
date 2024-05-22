import SwiftUI
import SwiftData
import Foundation

struct BillForm: View {
    
    // Environment
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext
    
    // State
    @State private var title = ""
    @State private var category = 0
    @State private var flow = Flow.expense
    @State private var interval = 1
    @State private var frequency = Frequency.monthly
    @State private var recurrence = Recurrence.indeterminate
    @State private var amount = ""
    @State private var date = Date.now
    
    // Queries
    @Query(
        sort: [
            SortDescriptor(\Category.name)
        ]
    )
    var categories: [Category]
    
    var body: some View {
        NavigationStack {
            
            // Form
            Form {
                Section(
                    header: Text("Basic Information"),
                    content: {
                        
                        // Title
                        TextField("Title", text: $title)
                        
                        // Category
                        Picker("Category", selection: $category) {
                            ForEach(categories.indices, id: \.self) { index in
                                Label (
                                    title: {
                                        Text(categories[index].name)
                                    },
                                    icon: {
                                        Text(categories[index].icon)
                                    }
                                )
                                .tag(index)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                        // Flow
                        Picker("Flow", selection: $flow) {
                            Text(Flow.expense.description).tag(Flow.expense)
                            Text(Flow.income.description).tag(Flow.income)
                        }
                        .pickerStyle(.menu)
                        
                        // Interval
                        Stepper("Interval: \(interval)", value: $interval, in: 1...365, step: 1)
                        
                        // Frequency
                        Picker("Frequency", selection: $frequency) {
                            Text(Frequency.daily.description).tag(Frequency.daily)
                            Text(Frequency.weekly.description).tag(Frequency.weekly)
                            Text(Frequency.monthly.description).tag(Frequency.monthly)
                            Text(Frequency.quarterly.description).tag(Frequency.quarterly)
                            Text(Frequency.annually.description).tag(Frequency.annually)
                        }
                        .pickerStyle(.menu)
                        
                        // Recurrence
                        Picker("Recurrence", selection: $recurrence) {
                            Text(Recurrence.determined.description).tag(Recurrence.determined)
                            Text(Recurrence.indeterminate.description).tag(Recurrence.indeterminate)
                        }
                        .pickerStyle(.menu)
                        
                        TextField("Amount", text: $amount)
                        
                        DatePicker(
                            selection: $date,
                            in: Date.now...,
                            displayedComponents: .date,
                            label: {
                                Text("Date")
                            }
                        )
                    }
                )
            }
            
            .navigationTitle("New Bill")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                
                // Cancel Button
                ToolbarItem(
                    placement: .topBarLeading,
                    content: {
                        Button(
                            action: onCancel,
                            label: {
                                Text("Cancel")
                            }
                        )
                    }
                )

                // Done Button
                ToolbarItem(
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: onDone,
                            label: {
                                Text("Done")
                            }
                        )
                        .disabled(title.isEmpty || amount.isEmpty)
                    }
                )
            }
        }
    }
    
    func onCancel() {
        presentationMode.wrappedValue.dismiss()
    }
    func onDone() {
        
        let bill = Bill(
            title: title,
            category: categories[category],
            flow: flow,
            interval: interval,
            frequency: frequency,
            recurrence: recurrence,
            amount: amount.toFloat,
            date: date
        )
        
        modelContext.insert(bill)

        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save bill")
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
