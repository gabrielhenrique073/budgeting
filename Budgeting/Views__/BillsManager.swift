//import SwiftUI
//
//struct BillsManager: View {
//    
//    @Environment(\.managedObjectContext) private var managedObjectContext
//    
//    @FetchRequest(sortDescriptors: []) private var bills: FetchedResults<Bill>
//    
//    @State private var isCreatorOpen = false
//    @State private var billTitle = ""
//    @State private var billAmount = ""
//    
//    var body: some View {
//        NavigationStack {
//            
//            // Content
//            List {
//                Section(
//                    header: Text("Registered Bills"),
//                    footer: Text("The bills you register will show up in the Monitor tab according to their recurrence"),
//                    content: {
//                        
//                        // Categories
//                        ForEach(bills, id: \.self) { item in
//                            Label (
//                                title: {
//                                    Text(item.title ?? "")
//                                },
//                                icon: {
////                                    Text(item.icon ?? "")
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
//            .navigationTitle("Bills")
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
//                                    
//                                }
//                            )
//                        }
//                        
//                        // Title
//                        .navigationTitle("New Bill")
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
//                                            
//
//                                            isCreatorOpen.toggle()
//                                        },
//                                        label: {
//                                            Text("Done")
//                                        }
//                                    )
//                                    .disabled(billTitle.isEmpty || billAmount.isEmpty)
//                                }
//                            )
//                        }
//                    }
//                }
//            )
//        }
//    }
//}
