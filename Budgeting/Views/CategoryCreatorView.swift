import SwiftUI
import CoreData

struct CategoryCreatorView: View {
    
    enum FocusableFields: Hashable {
        case name
    }
    
    private var context: NSManagedObjectContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var model: CategoryCreatorModel
    
    @FocusState private var focusedField: FocusableFields?
    
    @State private var name = ""
    @State private var icon = ""
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        _model = State(
            initialValue: CategoryCreatorModel(
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
                                
                                model.create(
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
            
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
