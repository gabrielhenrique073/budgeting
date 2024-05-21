import SwiftUI
import SwiftData
import Foundation

struct CategoryForm: View {
    
    // Environment
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.modelContext) private var modelContext
    
    // State
    @State private var name = ""
    @State private var icon = ""
    
    var body: some View {
        NavigationStack {
            
            // Form
            Form {
                Section(
                    header: Text("Basic Information"),
                    content: {
                        TextField("Title", text: $name)
                        TextField("Icon", text: $icon)
                    }
                )
            }
            
            .navigationTitle("New Category")
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
                        .disabled(name.isEmpty)
                    }
                )
            }
        }
    }
    
    func onCancel() {
        presentationMode.wrappedValue.dismiss()
    }
    func onDone() {
        
        let category = Category(
            name: name,
            icon: icon
        )
        
        modelContext.insert(category)
        
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save category")
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
