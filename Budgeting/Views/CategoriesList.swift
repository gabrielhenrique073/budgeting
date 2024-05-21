import SwiftUI
import SwiftData
import Foundation

struct CategoriesList: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var isCreating: Bool = false
    @State private var editingCategory: Category? = nil
    
    @Query(
        sort: [
            SortDescriptor(\Category.name)
        ]
    )
    var categories: [Category]
    
    var body: some View {
        NavigationStack {
            
            // List
            List {
                Section(
                    header: Text("Registered Categories"),
                    footer: Text("These categories are available for you to use the way you most like to organize your bills"),
                    content: {
                        ForEach(categories) { category in
                            Label (
                                title: {
                                    Text(category.name)
                                },
                                icon: {
                                    Text(category.icon)
                                }
                            )
                            .swipeActions {
                                
                                // Delete Button
                                Button(
                                    action: {
                                        modelContext.delete(category)
                                    },
                                    label: {
                                        Text("Delete")
                                    }
                                )
                                .tint(.red)
                                
                                // Edit Button
                                Button(
                                    action: {
                                        editingCategory = category
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
            
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            
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
                    CategoryForm()
                }
            )
            
            // Editor Sheet
            .sheet(
                item: $editingCategory,
                content: { category in
                    CategoryForm()
                }
            )
        }
    }
}
