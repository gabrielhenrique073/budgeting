import CoreData
import SwiftUI

extension BillsView {
    final class BillsModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func delete(item: Bill) {
            
            context.delete(item)
            
            do {
               try context.save()
            } catch {
                fatalError("Failed to delete bill")
            }
        }
    }
}
