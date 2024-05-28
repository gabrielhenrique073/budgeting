import CoreData
import SwiftUI

extension BillEditorView {
    final class BillEditorModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func edit(item: Bill, name: String) {
            item.name = name
            
            do {
                try context.save()
            } catch {
                fatalError("Failed to edit bill")
            }
        }
    }
}
