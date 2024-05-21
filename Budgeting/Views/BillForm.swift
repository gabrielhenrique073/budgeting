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
    @State private var isExpense = true
    @State private var isRecurrent = false
    @State private var amount = ""
    @State private var dueAt = Date.now
    
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
                        
                        // Is Expense
                        Toggle(
                            isOn: $isExpense,
                            label: {
                                Text("Is Expense")
                            }
                        )
                        
                        // Is Recurrent
                        Toggle(
                            isOn: $isRecurrent,
                            label: {
                                Text("Is Recurrent")
                            }
                        )
                        
                        TextField("Amount", text: $amount)
                        
                        DatePicker(
                            selection: $dueAt,
                            in: Date.now...,
                            displayedComponents: .date,
                            label: {
                                Text("Due At")
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
            category: categories[category]
        )
        bill.amount = Float(amount) ?? 0.0
        bill.dueAt = dueAt
        bill.isExpense = isExpense
        bill.isRecurrent = isRecurrent
        
        modelContext.insert(bill)

        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save bill")
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
