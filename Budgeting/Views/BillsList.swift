import SwiftUI
import SwiftData
import Foundation

struct BillsList: View {
    
    // Environment
    @Environment(\.modelContext) private var modelContext
    @State private var isCreating: Bool = false
    @State private var editingBiil: Bill? = nil
    
    // Queries
    @Query(
        sort: [
            SortDescriptor(\Bill.title)
        ]
    )
    var bills: [Bill]
    
    var body: some View {
        NavigationStack {
            
            // List
            List {
                Section(
                    header: Text("Registered Bills"),
                    content: {
                        ForEach(bills) { bill in
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
                            .swipeActions {
                                
                                // Delete Button
                                Button(
                                    action: {
                                        modelContext.delete(bill)
                                    },
                                    label: {
                                        Text("Delete")
                                    }
                                )
                                .tint(.red)
                                
                                // Edit Button
                                Button(
                                    action: {
                                        editingBiil = bill
                                    },
                                    label: {
                                        Text("Edit")
                                    }
                                )
                                .tint(.orange)
                            }
                        }
                    }
                )
            }
            
            .navigationTitle("Bills")
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                
                // Create Button
                ToolbarItem(
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: {
                                isCreating.toggle()
                            },
                            label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        )
                    }
                )
            }
            
            // Creator Sheet
            .sheet(
                isPresented: $isCreating,
                content: {
                    BillForm()
                }
            )
            
            // Editor Sheet
            .sheet(
                item: $editingBiil,
                content: { bill in
                    BillForm()
                }
            )
        }
    }
}
