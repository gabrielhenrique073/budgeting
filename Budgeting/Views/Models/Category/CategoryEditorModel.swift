import CoreData
import SwiftUI

extension CategoryEditorView {
    final class CategoryEditorModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func edit(item: Category, name: String, icon: String) {
            item.name = name
            item.icon = icon
            
            do {
                try context.save()
            } catch {
                fatalError("Failed to edit category")
            }
        }
    }
}
