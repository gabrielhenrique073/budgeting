import SwiftUI
import CoreData

struct CategoriesView: View {
    
    private var context: NSManagedObjectContext
    
    @StateObject private var model: CategoriesModel
    
    @State private var isCategoryCreatorPresented = false
    @State private var categoryEditorItem: Category?
    @State private var isDataRemovalDialogPresented = false
    
    @FetchRequest(
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(key: "name", ascending: true)
        ]
    ) private var categories: FetchedResults<Category>
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        _model = StateObject(
            wrappedValue: CategoriesModel(
                context: context
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section(
                    header: Text("Registered Categories"),
                    footer: Text("Manage the available categories creating and deleting them"),
                    content: {
                        ForEach(categories, id: \.self) { item in
                            Label (
                                title: {
                                    Text(item.name ?? "")
                                },
                                icon: {
                                    Text(item.icon ?? "")
                                }
                            )
                            .swipeActions(edge: .leading) {
                                Button(
                                    action: {
                                        categoryEditorItem = item
                                    },
                                    label: {
                                        Image(systemName: "pencil")
                                    }
                                )
                                .tint(.orange)
                            }
                            .swipeActions(edge: .trailing) {
                                Button(
                                    action: {
                                        model.delete(item: item)
                                    },
                                    label: {
                                        Image(systemName: "trash")
                                    }
                                )
                                .tint(.red)
                            }
                        }
                    }
                )
            }
            
            .toolbar {
                ToolbarItem (
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: {
                                isCategoryCreatorPresented.toggle()
                            },
                            label: {
                                Image(systemName: "plus.circle.fill")
                            }
                        )
                    }
                )
            }
            
            .sheet(
                isPresented: $isCategoryCreatorPresented,
                content: {
                    CategoryCreatorView(context: context)
                }
            )
            .sheet(
                item: $categoryEditorItem,
                content: { item in
                    CategoryEditorView(context: context, item: item)
                }
            )
            
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
