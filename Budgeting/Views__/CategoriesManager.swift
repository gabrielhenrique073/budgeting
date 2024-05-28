//import SwiftUI
//
//struct CategoriesManager: View {
//    
//    @Environment(\.managedObjectContext) private var managedObjectContext
//    
//    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<Category>
//    
//    @State private var isCreatorOpen = false
//    @State private var categoryName = ""
//    @State private var categoryIcon = ""
//    
//    var body: some View {
//        NavigationStack {
//            
//            // Content
//            List {
//                Section(
//                    header: Text("Registered Categories"),
//                    footer: Text("The bills you register will show up in the Monitor tab according to their recurrence"),
//                    content: {
//                        
//                        // Categories
//                        ForEach(categories, id: \.self) { item in
//                            Label (
//                                title: {
//                                    Text(item.name ?? "")
//                                },
//                                icon: {
//                                    Text(item.icon ?? "")
//                                }
//                            )
//                            .swipeActions {
//                                
//                                // Delete
//                                Button(
//                                    action: {
//                                        managedObjectContext.delete(item)
//
//                                        do {
//                                            try managedObjectContext.save()
//                                        } catch {
//                                            fatalError("Failed to delete category")
//                                        }
//                                    },
//                                    label: {
//                                        Text("Delete")
//                                    }
//                                )
//                                .tint(.red)
//                                
//                                // Edit
//                                Button(
//                                    action: {
//                                        
//                                    },
//                                    label: {
//                                        Text("Edit")
//                                    }
//                                )
//                                .tint(.orange)
//                            }
//                        }
//                    }
//                )
//            }
//            
//            // Title
//            .navigationTitle("Categories")
//            .navigationBarTitleDisplayMode(.inline)
//            
//            // Toolbar
//            .toolbar {
//                ToolbarItem(
//                    placement: .topBarTrailing,
//                    content: {
//                        Button(
//                            action: {
//                                isCreatorOpen.toggle()
//                            },
//                            label: {
//                                Image(systemName: "plus.circle.fill")
//                            }
//                        )
//                    }
//                )
//            }
//            
//            // Creator
//            .sheet(
//                isPresented: $isCreatorOpen,
//                content: {
//                    NavigationStack {
//                        
//                        // Content
//                        Form {
//                            Section(
//                                header: Text("Basic Information"),
//                                content: {
//                                    TextField("Title", text: $categoryName)
//                                    TextField("Icon", text: $categoryIcon)
//                                }
//                            )
//                        }
//                        
//                        // Title
//                        .navigationTitle("New Category")
//                        .navigationBarTitleDisplayMode(.inline)
//                        
//                        // Toolbar
//                        .toolbar {
//                            
//                            // Cancel
//                            ToolbarItem(
//                                placement: .topBarLeading,
//                                content: {
//                                    Button(
//                                        action: {
//                                            isCreatorOpen.toggle()
//                                        },
//                                        label: {
//                                            Text("Cancel")
//                                        }
//                                    )
//                                }
//                            )
//                            
//                            // Done
//                            ToolbarItem(
//                                placement: .topBarTrailing,
//                                content: {
//                                    Button(
//                                        action: {
//                                            let category = Category(context: managedObjectContext)
//                                            category.id = UUID()
//                                            category.name = categoryName
//                                            category.icon = categoryIcon
//
//                                            do {
//                                                try managedObjectContext.save()
//                                            } catch {
//                                                fatalError("Failed to save new category")
//                                            }
//
//                                            isCreatorOpen.toggle()
//                                        },
//                                        label: {
//                                            Text("Done")
//                                        }
//                                    )
//                                    .disabled(categoryName.isEmpty || categoryIcon.isEmpty)
//                                }
//                            )
//                        }
//                    }
//                }
//            )
//        }
//    }
//}
