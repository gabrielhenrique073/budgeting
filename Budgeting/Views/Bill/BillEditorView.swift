import SwiftUI
import CoreData

struct BillEditorView: View {
    
    enum FocusableFields: Hashable {
        case name
    }
    
    private var context: NSManagedObjectContext
    private var item: Bill
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var model: BillEditorModel
    
    @FocusState private var focusedField: FocusableFields?
    
    @State private var name: String
    
    init(context: NSManagedObjectContext, item: Bill) {
        self.context = context
        self.item = item
        
        self.name = item.name ?? ""
        
        _model = State(
            initialValue: BillEditorModel(
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
                            action: onCancel,
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
                            action: onDone,
                            label: {
                                Text("Done")
                            }
                        )
                        .disabled(name.isEmpty)
                    }
                )
            }
            
            .navigationTitle("Edit Bill")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func onCancel() {
        dismiss()
    }
    func onDone() {
        model.edit(
            item: item,
            name: name
        )
        
        dismiss()
    }
}
