import CoreData
import SwiftUI

extension CategoriesView {
    final class CategoriesModel: ObservableObject {
        
        private var context: NSManagedObjectContext
        
        init(context: NSManagedObjectContext) {
            self.context = context
        }
        
        func delete(item: Category) {
            
            context.delete(item)
            
            do {
               try context.save()
            } catch {
                fatalError("Failed to delete category")
            }
        }
    }
}
