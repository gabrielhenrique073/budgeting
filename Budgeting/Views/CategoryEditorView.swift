import SwiftUI
import CoreData

struct CategoryEditorView: View {
    
    enum FocusableFields: Hashable {
        case name
    }
    
    private var context: NSManagedObjectContext
    private var item: Category
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var model: CategoryEditorModel
    
    @FocusState private var focusedField: FocusableFields?
    
    @State private var name: String
    @State private var icon: String
    
    init(context: NSManagedObjectContext, item: Category) {
        self.context = context
        self.item = item
        
        self.name = item.name ?? ""
        self.icon = item.icon ?? ""
        
        _model = State(
            initialValue: CategoryEditorModel(
                context: context
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(
                    header: Text("Basic Information"),
                    content: {
                        TextField("Name", text: $name)
                            .focused($focusedField, equals: .name)
                        TextField("Icon", text: $icon)
                    }
                )
            }
            
            .onAppear {
                focusedField = .name
            }
            
            .toolbar {
                ToolbarItem (
                    placement: .topBarLeading,
                    content: {
                        Button(
                            action: {
                                dismiss()
                            },
                            label: {
                                Text("Cancel")
                            }
                        )
                    }
                )
                ToolbarItem (
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            action: {
                                
                                model.edit(
                                    item: item,
                                    name: name,
                                    icon: icon
                                )
                                
                                dismiss()
                            },
                            label: {
                                Text("Done")
                            }
                        )
                        .disabled(name.isEmpty)
                    }
                )
            }
            
            .navigationTitle("Edit Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
